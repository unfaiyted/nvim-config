-- ~/.config/nvim-dane/lua/custom/plugins/godoc-swagger.lua
return {
  'godoc-swagger',
  name = 'godoc-swagger',
  config = function()
    -- Define highlighting groups with muted Rose Pine color palette
    vim.cmd [[
      " Muted Rose Pine colors for Godoc Swagger highlighting
      highlight default GodocSwaggerTag ctermfg=176 guifg=#a794c7 gui=italic     " Muted Iris (purple)
      highlight default GodocSwaggerParam ctermfg=180 guifg=#c9a5a3 gui=italic   " Muted Rose (pink/salmon)
      highlight default GodocSwaggerSuccess ctermfg=107 guifg=#87b3ba gui=italic " Muted Foam (teal)
      highlight default GodocSwaggerFailure ctermfg=203 guifg=#c26580 gui=italic " Muted Love (red)
      highlight default GodocSwaggerRouter ctermfg=107 guifg=#d1a86a gui=italic  " Muted Gold (amber)
      highlight default GodocSwaggerDescription ctermfg=249 guifg=#7d7a93        " More muted text
      highlight default GodocSwaggerSecurity ctermfg=215 guifg=#c78d8b gui=italic " Muted Pine (red/pink)
      
      " New detailed highlights - muted
      highlight default GodocSwaggerStatusCode ctermfg=109 guifg=#87b3ba         " Muted Foam for status codes
      highlight default GodocSwaggerTypeObject ctermfg=152 guifg=#2e647c         " Muted Pine (blue) for type objects
      highlight default GodocSwaggerDescriptionText ctermfg=249 guifg=#6e6a86    " Muted text for description comments
    ]]

    -- Create an autocommand group for the plugin
    local augroup = vim.api.nvim_create_augroup('GodocSwagger', { clear = true })

    -- Define the highlighting function
    local function apply_highlighting()
      vim.fn.clearmatches() -- Clear existing matches to avoid duplicates

      -- Basic tags
      vim.fn.matchadd('GodocSwaggerTag', '// @\\(Summary\\|Description\\|Tags\\|Accept\\|Produce\\|Router\\|Security\\)', 100)
      vim.fn.matchadd('GodocSwaggerParam', '// @Param\\s\\+\\S\\+', 100)

      -- Success with enhanced parts
      vim.fn.matchadd('GodocSwaggerSuccess', '// @Success', 100)
      vim.fn.matchadd('GodocSwaggerStatusCode', '@Success\\s\\+\\d\\+', 100)
      vim.fn.matchadd('GodocSwaggerTypeObject', '{[^}]*}\\s\\+[a-zA-Z0-9_.\\[\\]]*', 100)

      -- Failure with enhanced parts
      vim.fn.matchadd('GodocSwaggerFailure', '// @Failure', 100)
      vim.fn.matchadd('GodocSwaggerStatusCode', '@Failure\\s\\+\\d\\+', 100)

      -- Router path
      vim.fn.matchadd('GodocSwaggerRouter', '// @Router\\s\\+\\S\\+', 100)

      -- Descriptions (quoted text)
      vim.fn.matchadd('GodocSwaggerDescriptionText', '"[^"]*"', 100)

      -- Security
      vim.fn.matchadd('GodocSwaggerSecurity', '@Security\\s\\+\\S\\+', 100)

      -- Print a message to confirm highlighting was applied
      vim.api.nvim_echo({ { 'Muted Rose Pine Godoc Swagger highlighting applied', 'Normal' } }, true, {})
    end

    -- Add autocommand to apply highlighting for Go files
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter', 'BufRead' }, {
      group = augroup,
      pattern = '*.go',
      callback = function()
        vim.api.nvim_create_autocmd('BufWinEnter', {
          buffer = 0,
          once = true,
          callback = apply_highlighting,
        })

        -- Apply immediately for the current buffer
        apply_highlighting()
      end,
    })

    -- Create a command to manually apply highlighting
    vim.api.nvim_create_user_command('GodocHighlight', apply_highlighting, {})

    -- Ensure highlighting persists after colorscheme changes
    vim.api.nvim_create_autocmd('ColorScheme', {
      group = augroup,
      callback = apply_highlighting,
    })

    -- Return the module to make it available
    return {
      apply_highlighting = apply_highlighting,
    }
  end,
}
