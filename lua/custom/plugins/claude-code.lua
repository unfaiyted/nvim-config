--- @type LazySpec
return {
  'daltonkyemiller/claude-code.nvim',
  -- dev = true,
  -- dir = "~/dev/nvim-plugins/claude-code.nvim",
  build = 'cd node && npm install',
  ---@type claude-code.ConfigInput
  opts = {
    window = {
      position = 'float',
    },
    keymaps = {
      submit = '<C-s>',
    },
  },
  keys = {
    {
      '<leader>cc',
      function()
        require('claude-code.commands').toggle()
      end,
    },
  },
}
