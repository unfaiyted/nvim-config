-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")

local map = Util.safe_keymap_set

map("n", "<C-S-Tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<C-Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map({ "i", "x", "n", "s" }, "<C-W>", "<cmd>bd<cr><esc>", { desc = "Exit file" })
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "window left" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "window right" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "window down" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "window up" })
-- map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
-- map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
