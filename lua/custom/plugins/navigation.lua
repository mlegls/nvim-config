return {
  'tpope/vim-unimpaired',
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    -- Lazy-load on the harpoon keymaps. (Previously this lived in `init`, which
    -- runs at startup and `require`d harpoon there, force-loading it — and
    -- telescope — on every launch.)
    -- Uses the `<leader>m` (marks) namespace to avoid colliding with the
    -- gitsigns `<leader>h` (Git Hunk) group.
    keys = {
      '<leader>ma',
      '<leader>mm',
      '<leader>m1',
      '<leader>m2',
      '<leader>m3',
      '<leader>m4',
      '<leader>mp',
      '<leader>mn',
    },
    config = function()
      local harpoon = require 'harpoon'

      -- REQUIRED
      harpoon:setup()
      -- REQUIRED

      local conf = require('telescope.config').values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require('telescope.pickers')
          .new({}, {
            prompt_title = 'Harpoon',
            finder = require('telescope.finders').new_table {
              results = file_paths,
            },
            previewer = conf.file_previewer {},
            sorter = conf.generic_sorter {},
          })
          :find()
      end

      -- keymaps (under the `<leader>m` marks namespace)
      vim.keymap.set('n', '<leader>ma', function()
        harpoon:list():add()
      end, { desc = 'Harpoon [m]ark [a]dd file' })
      -- vim.keymap.set('n', '<leader>mm', function()
      --   harpoon.ui:toggle_quick_menu(harpoon:list())
      -- end)
      vim.keymap.set('n', '<leader>mm', function()
        toggle_telescope(harpoon:list())
      end, { desc = 'Harpoon [m]enu' })

      vim.keymap.set('n', '<leader>m1', function()
        harpoon:list():select(1)
      end, { desc = 'Harpoon slot 1' })
      vim.keymap.set('n', '<leader>m2', function()
        harpoon:list():select(2)
      end, { desc = 'Harpoon slot 2' })
      vim.keymap.set('n', '<leader>m3', function()
        harpoon:list():select(3)
      end, { desc = 'Harpoon slot 3' })
      vim.keymap.set('n', '<leader>m4', function()
        harpoon:list():select(4)
      end, { desc = 'Harpoon slot 4' })

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set('n', '<leader>mp', function()
        harpoon:list():prev()
      end, { desc = 'Harpoon [p]rev' })
      vim.keymap.set('n', '<leader>mn', function()
        harpoon:list():next()
      end, { desc = 'Harpoon [n]ext' })
    end,
  },
}
