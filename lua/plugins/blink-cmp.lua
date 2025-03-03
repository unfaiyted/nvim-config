return {
  "saghen/blink.compat",
  optional = true, -- make optional so it's only enabled if any extras need it
  opts = {},
  version = not vim.g.lazyvim_blink_main and "*",
}
-- return {
--   "saghen/blink.cmp",
--   ---@module 'blink.cmp'
--   ---@type blink.cmp.Config
--   opts = {
--     sources = {
--       default = { "codecompanion" },
--       providers = {
--         codecompanion = {
--           name = "CodeCompanion",
--           module = "codecompanion.providers.completion.blink",
--           enabled = true,
--         },
--       },
--     },
--   },
--   opts_extend = {
--     "sources.default",
--   },
-- }
