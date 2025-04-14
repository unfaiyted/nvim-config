return {
  'kevinhwang91/nvim-ufo',
  config = function()
    -- Use standard UFO setup
    require('ufo').setup {
      provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
      end,
    }

    -- Standard UFO keymaps
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
    vim.keymap.set('n', 'K', function()
      local winid = require('ufo').peekFoldedLinesUnderCursor()
      if not winid then
        vim.lsp.buf.hover()
      end
    end)

    -- Add a specific keymap for folding Go log lines
    vim.keymap.set('n', 'zL', function()
      -- Only apply to Go files
      if vim.bo.filetype ~= 'go' then
        vim.notify('Not a Go file', vim.log.levels.WARN)
        return
      end

      local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
      local ranges = {}
      local start_line = nil

      -- Function to determine if a line is part of a Go log statement
      local function isLogStart(line)
        return line:match 'log%.' and (line:match 'Error%(%)' or line:match 'Info%(%)' or line:match 'Debug%(%)' or line:match 'Warn%(%)')
      end

      -- Function to determine if a line is the end of a log statement
      local function isLogEnd(line)
        return line:match 'Msg%('
      end

      -- Find all log statement ranges
      for i, line in ipairs(lines) do
        if isLogStart(line) then
          start_line = i
        elseif isLogEnd(line) and start_line then
          table.insert(ranges, { start_line, i })
          start_line = nil
        end
      end

      -- Create folds for each range
      for _, range in ipairs(ranges) do
        vim.cmd(range[1] .. ',' .. range[2] .. 'fold')
      end

      vim.notify('Folded ' .. #ranges .. ' log statements')
    end, { desc = 'Fold Go log statements' })
  end,
  init = function()
    vim.o.foldcolumn = '0'
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
  end,
  dependencies = {
    { 'kevinhwang91/promise-async' },
  },
}
