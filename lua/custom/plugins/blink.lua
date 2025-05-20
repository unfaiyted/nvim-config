--- @type LazySpec
return {
  'saghen/blink.cmp',
  lazy = false,
  -- optional: provides snippets for the snippet source
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      keys = {},
      init = function()
        require('luasnip.loaders.from_snipmate').load()
        require('luasnip.loaders.from_lua').load {
          paths = { '~/.config/nvim/snippets' },
        }
      end,
    },
  },

  -- use a release tag to download pre-built binaries
  version = '*',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {

    snippets = { preset = 'luasnip' },
    signature = { enabled = true },
    completion = {
      menu = {
        max_height = 18,
      },

      list = {
        selection = {
          preselect = function(ctx)
            return ctx.mode == 'default' and true or false
          end,
        },
      },
    },
    -- Enable

    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- See the full "keymap" documentation for information on defining your own keymap.
    keymap = {
      preset = 'default',
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },
    },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Will be removed in a future release
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      -- 'codecompanion'
      default = { 'lsp', 'snippets', 'path', 'buffer' },
      providers = {
        lsp = {
          transform_items = function(_, items)
            return vim.tbl_filter(function(item)
              return not (item.labelDetails and item.labelDetails.description and string.find(item.labelDetails.description, 'lucide'))
            end, items)
          end,
          async = true,
          name = 'LSP',
          module = 'blink.cmp.sources.lsp',
          -- max_items = 20,
        },
        -- codecompanion = {
        --   name = 'CodeCompanion',
        --   module = 'codecompanion.providers.completion.blink',
        --   enabled = true,
        -- },
      },
    },
  },
  opts_extend = { 'sources.default' },
}
