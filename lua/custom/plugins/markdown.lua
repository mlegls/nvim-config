return {
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = 'cd app && bun i',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown' },
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
  {
    'zk-org/zk-nvim',
    -- Lazy-load when a zk command or keymap is first used, rather than running
    -- setup (and registering keymaps) eagerly at startup.
    cmd = { 'ZkNew', 'ZkNotes', 'ZkTags', 'ZkMatch', 'ZkNewFromTitleSelection', 'ZkNewFromContentSelection' },
    keys = {
      { '<leader>zn', "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", desc = 'zk [n]ew note' },
      -- Open notes.
      { '<leader>zo', "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", desc = 'zk [o]pen notes' },
      -- Open notes associated with the selected tags.
      { '<leader>zt', '<Cmd>ZkTags<CR>', desc = 'zk [t]ags' },
      -- Search for the notes matching a given query.
      { '<leader>zf', "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>", desc = 'zk [f]ind notes' },
      -- Search for the notes matching the current visual selection.
      { '<leader>zf', ":'<,'>ZkMatch<CR>", mode = 'v', desc = 'zk match selection' },
    },
    config = function()
      require('zk').setup {
        picker = 'telescope',
      }
    end,
  },
  -- {
  --   'epwalsh/obsidian.nvim',
  --   version = '*', -- recommended, use latest release instead of latest commit
  --   lazy = true,
  --   ft = 'markdown',
  --   -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  --   -- event = {
  --   --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   --   -- refer to `:h file-pattern` for more examples
  --   --   "BufReadPre path/to/my-vault/*.md",
  --   --   "BufNewFile path/to/my-vault/*.md",
  --   -- },
  --   dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim', 'nvim-treesitter/nvim-treesitter' },
  --   opts = {
  --     workspaces = {
  --       {
  --         name = 'alkahest',
  --         path = '~/.nb/alkahest',
  --       },
  --     },
  --
  --     -- see below for full list of options 👇
  --   },
  -- },
}
