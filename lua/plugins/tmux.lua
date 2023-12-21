-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- add gruvbox
  -- {
  --   "alexghergh/nvim-tmux-navigation",
  --   -- add a keymap to browse plugin files
  --   config = function()
  --     require("nvim-tmux-navigation").setup({
  --       disable_when_zoomed = true, -- defaults to false
  --       keybindings = {
  --         left = "<C-h>",
  --         down = "<C-j>",
  --         up = "<C-k>",
  --         right = "<C-l>",
  --         last_active = "<C-\\>",
  --         next = "<C-Space>",
  --       },
  --     })
  --   end,
  -- },

  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "tpope/vim-obsession",
  },
}
