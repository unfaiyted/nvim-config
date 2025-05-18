return {
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      -- Explicitly enable all treesitter modules for installed languages
      local parsers = require('nvim-treesitter.parsers')
      local configs = require('nvim-treesitter.configs')
      
      -- Force reload treesitter configuration
      configs.setup({
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = { enable = true },
        textobjects = { enable = true },
      })
      
      -- Create autocmd to ensure modules are enabled for each buffer
      vim.api.nvim_create_autocmd({ "BufEnter", "BufRead" }, {
        callback = function()
          local ft = vim.bo.filetype
          local lang = parsers.ft_to_lang(ft)
          
          if parsers.has_parser(lang) then
            -- Explicitly start parser for this buffer
            vim.treesitter.start(vim.api.nvim_get_current_buf(), lang)
            
            -- Force enable highlighting for this buffer
            vim.cmd("TSBufEnable highlight")
            vim.cmd("TSBufEnable incremental_selection")
            vim.cmd("TSBufEnable indent")
          end
        end,
      })
    end,
  }
}