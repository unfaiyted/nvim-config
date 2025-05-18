return {
  {
    -- Add custom filetype detection for HTTP files
    "nvim-treesitter/nvim-treesitter",
    config = function()
      -- Define an autocmd to set the right filetype for HTTP files
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = { "*.http", "*.rest" },
        callback = function()
          -- Set both the filetype AND ensure treesitter parser is used
          vim.bo.filetype = "http"
          -- Force the treesitter parser to be http
          vim.treesitter.start(vim.api.nvim_get_current_buf(), "http")
        end,
      })
    end,
  },
}