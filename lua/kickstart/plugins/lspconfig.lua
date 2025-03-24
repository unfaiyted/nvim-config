-- -- [[ Configure LSP ]]
-- --  This function gets run when an LSP connects to a particular buffer.
-- local on_attach = function(client, bufnr)
--   local nmap = function(keys, func, desc)
--     if desc then
--       desc = 'LSP: ' .. desc
--     end
--
--     vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
--   end
--
--   -- Golang handling
--   if not client.server_capabilities.semanticTokensProvider then
--     local semantic = client.config.capabilities.textDocument.semanticTokens
--     client.server_capabilities.semanticTokensProvider = {
--       full = true,
--       legend = {
--         tokenTypes = semantic.tokenTypes,
--         tokenModifiers = semantic.tokenModifiers,
--       },
--       range = true,
--     }
--   end
--
--   if client.name == 'vtsls' then
--     nmap('<leader>co', function()
--       vim.lsp.buf.code_action {
--         apply = true,
--         context = {
--           only = { 'source.removeUnused.ts' },
--           diagnostics = {},
--         },
--       }
--     end, '[C]ode [O]rganize Imports')
--
--     nmap('<leader>cu', function()
--       vim.lsp.buf.code_action {
--         apply = true,
--         context = {
--           only = { 'source.removeUnused.ts' },
--           diagnostics = {},
--         },
--       }
--     end, '[C]ode Remove [U]nused Code')
--
--     nmap('<leader>cl', function()
--       vim.lsp.buf.code_action {
--         apply = true,
--         context = {
--           only = { 'source.fixAll.biome' },
--           diagnostics = {},
--         },
--       }
--     end, '[C]ode [L]int Fix All')
--
--     nmap('<leader>cL', function()
--       vim.lsp.buf.execute_command {
--         command = 'typescript.openTsServerLog',
--       }
--     end)
--
--     nmap('<leader>cR', function()
--       vim.lsp.buf.execute_command {
--         command = 'typescript.reloadProjects',
--       }
--     end, '[C]ode [R]estart Server')
--
--     nmap('<leader>cV', function()
--       vim.lsp.buf.execute_command {
--         command = 'typescript.selectTypeScriptVersion',
--       }
--     end, '[C]ode [V]ersion')
--
--     nmap('<leader>cD', function()
--       local position_params = vim.lsp.util.make_position_params()
--
--       vim.lsp.buf.execute_command {
--         command = 'typescript.goToSourceDefinition',
--         arguments = { vim.api.nvim_buf_get_name(0), position_params.position },
--       }
--     end, '[C]ode [D]efinition')
--   end
--
--   nmap('<leader>cr', vim.lsp.buf.rename, '[C]ode [R]ename')
--   nmap('<leader>cd', vim.diagnostic.open_float, '[C]ode [D]iagnostics')
--   nmap('<leader>ci', function()
--     local is_enabled = vim.lsp.inlay_hint.is_enabled {}
--     vim.lsp.inlay_hint.enable(not is_enabled)
--   end, '[C]ode [I]nlay Hints')
--
--   vim.keymap.set({ 'n', 'x' }, '<leader>ca', function()
--     vim.lsp.buf.code_action()
--   end, { desc = '[C]ode [A]ction' })
--
--   nmap('<leader>ca', function()
--     vim.lsp.buf.code_action { context = { only = { 'quickfix', 'refactor', 'source' } } }
--   end, '[C]ode [A]ction')
--
--   nmap('gd', require('snacks.picker').lsp_definitions, '[G]oto [D]efinition')
--   nmap('gD', require('snacks.picker').lsp_type_definitions, '[G]oto [D]efinition')
--   -- nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
--   -- nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
--   -- nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
--   -- nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
--   -- nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
--   -- nmap("<leader>d", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
--   -- nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
--
--   -- See `:help K` for why this keymap
--   nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
--   nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
--
--   -- Lesser used LSP functionality
--   -- nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
--   nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
--   nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
--   nmap('<leader>wl', function()
--     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--   end, '[W]orkspace [L]ist Folders')
-- end
--
-- local servers = {
--   vtsls = {
--     vtsls = {
--       autoUseWorkspaceTsdk = true,
--       experimental = {
--         completion = {
--           enableServerSideFuzzyMatch = true,
--           entriesLimit = 25,
--         },
--       },
--     },
--     typescript = {
--       preferences = {
--         includeCompletionsForImportStatements = true,
--       },
--       maxTsServerMemory = 16384,
--       inlayHints = {
--         parameterNames = {
--           enabled = 'all',
--         },
--         variableTypes = {
--           enabled = true,
--         },
--         propertyDeclarationTypes = {
--           enabled = true,
--         },
--         functionLikeReturnTypes = {
--           enabled = true,
--         },
--       },
--     },
--   },
--   prismals = {},
--   lua_ls = {
--     Lua = {
--       workspace = { checkThirdParty = false },
--       telemetry = { enable = false },
--       -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
--       diagnostics = { disable = { 'missing-fields' } },
--     },
--   },
--   svelte = {},
--   gopls = {
--     gofumpt = true,
--     codelenses = {
--       gc_details = false,
--       generate = true,
--       regenerate_cgo = true,
--       run_govulncheck = true,
--       test = true,
--       tidy = true,
--       upgrade_dependency = true,
--       vendor = true,
--     },
--     hints = {
--       assignVariableTypes = true,
--       compositeLiteralFields = true,
--       compositeLiteralTypes = true,
--       constantValues = true,
--       functionTypeParameters = true,
--       parameterNames = true,
--       rangeVariableTypes = true,
--     },
--     analyses = {
--       nilness = true,
--       unusedparams = true,
--       unusedwrite = true,
--       useany = true,
--     },
--     usePlaceholders = true,
--     completeUnimported = true,
--     staticcheck = true,
--     directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
--     semanticTokens = true,
--     filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
--   },
--   glsl_analyzer = {},
--   biome = {},
--   tailwindcss = {
--     tailwindCSS = {
--       experimental = {
--         -- classRegex = {
--         --   {
--         --     "cn\\(([^]*)\\)",
--         --     "(?:'|\"|`)([^\"'`]*)(?:'|\"|`)",
--         --   },
--         -- },
--       },
--     },
--   },
--   astro = {},
-- }
--
-- local vtsls_handlers = {
--   ['workspace/executeCommand'] = function(err, result, ctx, config)
--     if ctx.params.command ~= 'typescript.goToSourceDefinition' then
--       return
--     end
--     vim.print(vim.inspect(result))
--     if result == nil or #result == 0 then
--       return
--     end
--
--     vim.lsp.util.jump_to_location(result[1], 'utf-8')
--   end,
-- }
--
-- --- @type LazySpec
-- return {
--   -- LSP Configuration & Plugins
--   'neovim/nvim-lspconfig',
--   dependencies = {
--     -- Automatically install LSPs to stdpath for neovim
--     {
--       'williamboman/mason.nvim',
--       opts = function()
--         --- @type MasonSettings
--         return {
--           ui = {
--             icons = require('nvim-nonicons.extentions.mason').icons,
--           },
--           ensure_installed = {
--             'goimports',
--             'gofumpt',
--             'gomodifytags',
--             'impl',
--             'delve'
--           },
--         }
--       end,
--     },
--     { 'folke/neodev.nvim', config = true },
--     {
--       'williamboman/mason-lspconfig.nvim',
--       config = function()
--         local lspconfig = require 'lspconfig'
--         local blink_cmp = require 'blink.cmp'
--         local capabilities = blink_cmp.get_lsp_capabilities()
--
--         require('mason-lspconfig').setup {
--           ensure_installed = vim.tbl_keys(servers),
--           handlers = {
--             function(server_name)
--               local handlers = server_name == 'vtsls' and vtsls_handlers or {}
--
--               lspconfig[server_name].setup {
--                 capabilities = capabilities,
--                 on_attach = on_attach,
--                 settings = servers[server_name],
--                 filetypes = (servers[server_name] or {}).filetypes,
--                 handlers = handlers,
--               }
--             end,
--           },
--         }
--       end,
--     },
--   },
-- }
--
--
--
--

-- --
-- -- -- LSP Plugins
return {
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { 'williamboman/mason.nvim', opts = {} },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by nvim-cmp
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --

      -- attach keymaps
      local on_attach = function(client, bufnr)
        if client.name == 'svelte' then
          vim.api.nvim_create_autocmd('BufWritePost', {
            pattern = { '*.js', '*.ts' },
            group = vim.api.nvim_create_augroup('svelte_ondidchangetsorjsfile', { clear = true }),
            callback = function(ctx)
              -- Here use ctx.match instead of ctx.file
              client.notify('$/onDidChangeTsOrJsFile', { uri = ctx.match })
            end,
          })
        end

        attach_keymaps(client, bufnr)
      end
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Function to swap top and bottom split buffers
          function SwapTopBottomBuffers()
            -- Get all windows
            local wins = vim.api.nvim_list_wins()
            if #wins < 2 then
              return
            end

            -- Get window positions
            local win_positions = {}
            for _, win in ipairs(wins) do
              local pos = vim.api.nvim_win_get_position(win)
              win_positions[win] = pos[1] -- Row position (y-coordinate)
            end

            -- Sort windows by vertical position
            table.sort(wins, function(a, b)
              return win_positions[a] < win_positions[b]
            end)

            -- Get the top and bottom windows
            local top_win = wins[1]
            local bottom_win = wins[#wins]

            -- Swap buffers
            local top_buf = vim.api.nvim_win_get_buf(top_win)
            local bottom_buf = vim.api.nvim_win_get_buf(bottom_win)

            vim.api.nvim_win_set_buf(top_win, bottom_buf)
            vim.api.nvim_win_set_buf(bottom_win, top_buf)
          end

          -- Map it to a key
          -- vim.keymap.set('n', '<leader>sb', SwapTopBottomBuffers, { desc = 'Swap top/bottom buffers' })

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('snacks.picker').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('snacks.picker').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('snacks.picker').lsp_implementations, '[G]oto [I]mplementation')

          -- Open definition in a right split
          map('<leader>gdr', function()
            require('snacks.picker').lsp_definitions { jump_type = 'vsplit' }
          end, 'Open definition in right split')

          -- Open definition in a left split
          -- map('<leader>gdl', function()
          --   vim.cmd.normal 'mq' -- Mark current position
          --   vim.cmd 'vsplit' -- Split vertically first
          --   vim.cmd.normal '<C-h>' -- Move to left window
          --   require('telescope.builtin').lsp_definitions { initial_mode = 'normal' }
          --   -- vim.cmd.normal '`q' -- Return to original mark
          --   --
          -- end, 'Open definition in left split')
          --
          -- Open definition in a top split
          map('<leader>gdb', function()
            vim.cmd.normal 'mq' -- Mark current position
            vim.cmd 'split' -- Split horizontally first
            vim.cmd.normal '<C-k>' -- Move to top window
            require('snacks.picker').lsp_definitions { initial_mode = 'normal' }
            vim.cmd.normal '`q' -- Return to original mark
          end, 'Open definition in top split')

          -- Open definition in a bottom split
          -- map('<leader>gdt', function()
          --   require('telescope.builtin').lsp_definitions { jump_type = 'split' }
          --   -- vim.cmd.normal '<leader>sb' -- Move to left window
          --   --
          --   SwapTopBottomBuffers()
          -- end, 'Open definition in bottom split')
          --
          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', require('snacks.picker').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('snacks.picker').lsp_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>ws', require('snacks.picker').lsp_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
        -- ts_ls = {},
        --

        lua_ls = {
          -- cmd = { ... },
          -- filetypes = { ... },
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run
      --    :Mason
      --
      -- You can press `g?` for help in this menu.
      --
      -- `mason` had to be setup earlier: to configure its options see the
      -- `dependencies` table for `nvim-lspconfig` above.
      --
      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      local lspconfig = require 'lspconfig'
      local blink_cmp = require 'blink.cmp'
      local capabilities = blink_cmp.get_lsp_capabilities()

      require('mason-lspconfig').setup {
        ensure_installed = { 'svelte', 'gopls', 'vtsls' }, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
        automatic_installation = true,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            local handlers = server_name == 'vtsls' and vtsls_handlers or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})

            lspconfig[server_name].setup {
              capabilities = capabilities,
              -- on_attach = on_attach,
              settings = servers[server_name],
              filetypes = (servers[server_name] or {}).filetypes,
              handlers = handlers,
            }
            -- lorequire('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
--vim: ts=2 sts=2 sw=2 et
