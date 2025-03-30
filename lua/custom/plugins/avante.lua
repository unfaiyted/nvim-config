--- @type LazySpec
return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  version = '*', -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.

  ---@type avante.Config
  opts = {
    -- add any opts here
    -- for example
    provider = 'claude',
    claude = {
      model = 'claude-3-7-sonnet-latest',
      max_tokens = 8192,
    },
    openai = {
      endpoint = 'https://api.openai.com/v1',
      model = 'gpt-4o', -- your desired model (or use gpt-4o, etc.)
      timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
      temperature = 0,
      max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
      --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
    },
    file_selector = {
      provider = 'snacks',
    },
    behaviour = {
      -- auto_apply_diff_after_generation = true,
    },
    -- rag_service = {
    --   enabled = true,
    --   provider = 'openai', -- The LLM provider
    --   endpoint = 'https://api.openai.com/v1', -- API endpoint
    --   llm_model = 'gpt-3.5-turbo', -- LLM model to use
    --   embed_model = 'text-embedding-ada-002', -- Embedding model
    --   host_mount = os.getenv 'HOME' .. '/codebase', -- Directory to mount in the container
    --   runner = 'docker', -- "docker" or "nix"
    --   image = 'quay.io/yetoneful/avante-rag-service:0.0.9', -- Image to use for the RAG service
    -- },
    mappings = {
      --- @type AvanteConflictMappings
      diff = {
        ours = 'co',
        theirs = 'ct',
        all_theirs = 'ca',
        both = 'cb',
        cursor = 'cc',
        next = ']x',
        prev = '[x',
      },

      ask = '<leader>aa',
      edit = '<leader>ae',
      refresh = '<leader>ar',
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = 'make',
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'stevearc/dressing.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    --- The below dependencies are optional,
    {
      -- support for image pasting
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
  },
}
