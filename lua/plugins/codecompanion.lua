return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    --- The below is optional, make sure to setup it properly if you have lazy=true
    {
      "saghen/blink.cmp",
      lazy = false,
      enabled = true,
      version = "*",
      opts = {
        keymap = {
          preset = "enter",
          ["<S-Tab>"] = { "select_prev", "fallback" },
          ["<Tab>"] = { "select_next", "fallback" },
        },
        cmdline = { sources = { "cmdline" } },
        sources = {
          default = { "lsp", "path", "buffer", "codecompanion" },
          providers = {
            codecompanion = {
              name = "CodeCompanion",
              module = "codecompanion.providers.completion.blink",
              enabled = true,
            },
          },
        },
      },
      opts_extend = {
        "sources.default",
      },
    },
    {

      "MeanderingProgrammer/render-markdown.nvim",
      ft = { "markdown", "codecompanion" },
    },
  },
  config = function()
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "anthropic",
        },
        inline = {
          adapter = "anthropic",
        },
      },
    })
  end,
  keys = {
    {
      mode = { "n", "v" },
      "<A-a>",
      "<cmd>CodeCompanionActions<cr>",
      desc = "Open CodeCompanion actions",
    },
    {
      mode = { "n", "v" },
      "<LocalLeader>a",
      "<cmd>CodeCompanionChat Toggle<cr>",
      desc = "Toggle CodeCompanion chat",
    },
    {
      mode = "v",
      "ga",
      "<cmd>CodeCompanionChat Add<cr>",
      desc = "Add selection to CodeCompanion chat",
    },
  },
}
