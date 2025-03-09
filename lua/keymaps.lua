-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
--
-- In your lua/config/keymaps.lua:
local keymap = vim.keymap

vim.keymap.set('n', '<A-h>', '^', { desc = 'Go to start of line' })
vim.keymap.set('n', '<A-l>', '$', { desc = 'Go to end of line' })
vim.keymap.set('v', '<A-h>', '^', { desc = 'Go to start of line' })
vim.keymap.set('v', '<A-l>', '$', { desc = 'Go to end of line' })

-- Custom keybindings for splitting buffers
vim.keymap.set('n', '<leader>-', ':split<CR>', { desc = 'Horizontal Split' })
vim.keymap.set('n', '<leader>_', ':vsplit<CR>', { desc = 'Vertical Split' })

-- Or for even faster movement (10 lines):
vim.keymap.set('n', '<A-S-j>', '15j', { noremap = true, silent = true })
vim.keymap.set('n', '<A-S-k>', '15k', { noremap = true, silent = true })

-- Add this to your init.lua or other config file
vim.keymap.set('n', 'gb', '<C-o>', { noremap = true, desc = 'Go back to last cursor position' })
vim.keymap.set('n', 'gf', '<C-i>', { noremap = true, desc = 'Go forward to next cursor position' })
-- In lua/config/keymaps.lua

keymap.set('n', 'ge', function()
  local has_errors = false

  -- First check if there are any errors
  for _, diagnostic in ipairs(vim.diagnostic.get(0)) do
    if diagnostic.severity == vim.diagnostic.severity.ERROR then
      has_errors = true
      break
    end
  end

  -- If there are errors, go to next error, otherwise go to next diagnostic
  if has_errors then
    vim.diagnostic.goto_next { severity = vim.diagnostic.severity.ERROR }
  else
    vim.diagnostic.goto_next()
  end
end, { desc = 'Go to next error or diagnostic' })

vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
vim.keymap.set('n', '<leader>e', '<CMD>Neotree source=filesystem  position=float<CR>')
vim.keymap.set('n', '<leader><leader>', '<CMD>Neotree source=buffers  position=float<CR>')
-- vim.keymap.set('n', '<leader>e', '<CMD>Neotree source=buffers position=float<CR>')
-- vim.keymap.set('n', '<leader>e', '<CMD>Neotree position=float<CR>')
