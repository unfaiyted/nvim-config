-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Tab navigation
-- vim.keymap.set("n", "<C-S-H>", "<cmd>tabprevious<cr>", { desc = "Previous tab" })
-- vim.keymap.set("n", "<C-S-L>", "<cmd>tabnext<cr>", { desc = "Next tab" })
--

-- In your lua/config/keymaps.lua:
local keymap = vim.keymap

vim.keymap.set("n", "<A-h>", "^", { desc = "Go to start of line" })
vim.keymap.set("n", "<A-l>", "$", { desc = "Go to end of line" })
vim.keymap.set("v", "<A-h>", "^", { desc = "Go to start of line" })
vim.keymap.set("v", "<A-l>", "$", { desc = "Go to end of line" })

-- Custom keybindings for splitting buffers
vim.keymap.set("n", "<leader>-", ":split<CR>", { desc = "Horizontal Split" })
vim.keymap.set("n", "<leader>_", ":vsplit<CR>", { desc = "Vertical Split" })

-- Or for even faster movement (10 lines):
vim.keymap.set("n", "<A-S-j>", "15j", { noremap = true, silent = true })
vim.keymap.set("n", "<A-S-k>", "15k", { noremap = true, silent = true })

-- Add this to your init.lua or other config file
vim.keymap.set("n", "gb", "<C-o>", { noremap = true, desc = "Go back to last cursor position" })
vim.keymap.set("n", "gf", "<C-i>", { noremap = true, desc = "Go forward to next cursor position" })
-- In lua/config/keymaps.lua

keymap.set("n", "ge", function()
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
    vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
  else
    vim.diagnostic.goto_next()
  end
end, { desc = "Go to next error or diagnostic" })
