return {
  {
    'mistweaverco/kulala.nvim',
    -- keys = {
    --   { '<C-s>', desc = 'Send request' },
    --   { '<LocalLeader>r', desc = 'Open scratchpad' },
    --   { '<leader>Ra', desc = 'Send all requests' },
    --   -- { '<leader>Rb', desc = 'Open scratchpad' },
    -- },
    ft = { 'http', 'rest' },
    opts = {
      split_direction = 'vertical',
      global_keymaps = true,
      -- your configuration comes here
      --   global_keymaps = {
      --     ['Open scratchpad'] = {
      --       '<LocalLeader>r',
      --       function()
      --         require('kulala').scratchpad()
      --       end,
      --     },
      --     ['Send request'] = { -- sets global mapping
      --       '<C-s>',
      --       function()
      --         require('kulala').run()
      --       end,
      --       mode = { 'n', 'v' }, -- optional mode, default is n
      --       desc = 'Send request', -- optional description, otherwise inferred from the key
      --     },
      --     ['Send all requests'] = {
      --       '<leader>Ra',
      --       function()
      --         require('kulala').run_all()
      --       end,
      --       mode = { 'n', 'v' },
      --       ft = 'http', -- sets mapping for *.http files only
      --     },
      --     ['Replay the last request'] = {
      --       '<leader>Rr',
      --       function()
      --         require('kulala').replay()
      --       end,
      --       ft = { 'http', 'rest' }, -- sets mapping for specified file types
      --     },
      --     ['Find request'] = false, -- set to false to disable
      --   },
    },
  },
}
