--- @type LazySpec
return {
  'kevinhwang91/nvim-ufo',
  config = function()
    require('ufo').setup {}

    vim.keymap.set('n', 'K', function()
      local winid = require('ufo').peekFoldedLinesUnderCursor()
      if not winid then
        -- Execute your original K binding here
        vim.lsp.buf.hover()
      end
    end)
  end,
  init = function()
    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.o.foldcolumn = '0' -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = false
  end,
  dependencies = {
    { 'kevinhwang91/promise-async' },
  },
}
