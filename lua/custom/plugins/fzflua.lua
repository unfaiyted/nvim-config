return {
  'ibhagwan/fzf-lua',
  -- optional for icon support
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "echasnovski/mini.icons" },
  opts = {},
  config = function()
    local fzf = require 'fzf-lua'

    -- Set up default options if needed
    fzf.setup {
      -- Your existing FZF-Lua options here
    }

    -- Search for word under cursor across codebase
    vim.keymap.set('n', '<leader>fw', function()
      -- fzf.grep_cword()
      fzf.grep_cword { search = vim.fn.expand '<cword>', no_esc = true }
    end, { desc = '[F]ind [w]ord under cursor' })

    -- Search for string under cursor in project
    vim.keymap.set('n', '<leader>ss', function()
      fzf.grep_project { search = vim.fn.expand '<cword>' }
    end, { desc = '[S]earch project for [S]tring' })

    vim.keymap.set('n', '<leader>fp', function()
      fzf.live_grep()
    end, { desc = '[F]ind text in [p]roject' })

    -- Variant with preview window if desired
    vim.keymap.set('n', '<leader>fP', function()
      fzf.live_grep { previewer = true }
    end, { desc = '[F] text in [P]roject (with preview)' })

    -- Visual selection substitution helper
    vim.keymap.set('x', '<leader>r', function()
      local saved_unnamed_register = vim.fn.getreg '"'
      vim.cmd [[normal! "xy]]
      local text = vim.fn.getreg 'x'
      vim.fn.setreg('"', saved_unnamed_register)

      -- Escape special characters
      local escaped_text = vim.fn.escape(text, '/\\.*$^~[]')

      -- Set up the substitution command with the escaped text
      vim.fn.feedkeys(':%s/' .. escaped_text .. '/', 'n')
    end, { noremap = true, desc = 'Substitute visual selection' })

    -- Search for visually selected text in project
    vim.keymap.set('x', '<leader>fp', function()
      -- Save the current unnamed register
      local saved_unnamed_register = vim.fn.getreg '"'

      -- Yank the visual selection into register x
      vim.cmd [[normal! "xy]]

      -- Get the content of register x
      local text = vim.fn.getreg 'x'

      -- Restore the unnamed register
      vim.fn.setreg('"', saved_unnamed_register)

      -- Use the selected text for live grep search
      fzf.live_grep { search = text }
    end, { desc = '[F]ind selected text in [p]roject' })
  end,
}
