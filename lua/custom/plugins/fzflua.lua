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
    vim.keymap.set('n', '<leader>sw', function()
      -- fzf.grep_cword()
      fzf.grep_cword { search = vim.fn.expand '<cword>', no_esc = true }
    end, { desc = 'Find word under cursor' })

    -- Interactive search for word under cursor
    vim.keymap.set('n', '<leader>sW', function()
      fzf.grep_cword { interactive = true }
    end, { desc = 'Find word under cursor (interactive)' })

    -- Search for string under cursor in project
    vim.keymap.set('n', '<leader>sS', function()
      fzf.grep_project { search = vim.fn.expand '<cword>' }
    end, { desc = 'Find string under cursor in project' })

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
  end,
}
