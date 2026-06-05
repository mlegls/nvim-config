return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    -- The legacy `master` branch is frozen and incompatible with Neovim 0.12
    -- (its injection directive handlers break on the new query-match format,
    -- producing "attempt to call method 'range' (a nil value)" on markdown
    -- and other injected filetypes). The rewritten `main` branch is required.
    branch = 'main',
    lazy = false, -- the `main` branch does not support lazy-loading
    build = ':TSUpdate',
    config = function()
      local ts = require 'nvim-treesitter'

      ts.setup()

      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
      local ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'nix',
        'rust',
        'python',
        'typescript',
        'solidity',
        'go',
      }

      -- Install any parsers from the list that are missing (no-op otherwise).
      local installed = ts.get_installed()
      local missing = vim.tbl_filter(function(lang)
        return not vim.tbl_contains(installed, lang)
      end, ensure_installed)
      if #missing > 0 then
        ts.install(missing)
      end

      -- Enable highlighting + (experimental) treesitter indentation per buffer,
      -- auto-installing the parser on the fly. This replaces the old module
      -- system (`highlight`/`indent`/`auto_install`), which no longer exists on
      -- the `main` branch.
      local function attach(buf)
        local ft = vim.bo[buf].filetype
        local lang = vim.treesitter.language.get_lang(ft)
        if not lang then
          return
        end

        local function start()
          if not pcall(vim.treesitter.start, buf, lang) then
            return
          end
          -- Treesitter-based indentation (upstream considers this experimental).
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end

        if vim.tbl_contains(ts.get_installed(), lang) then
          start()
        else
          -- auto_install: fetch the parser, then start once it's ready
          ts.install(lang):await(function()
            vim.schedule(start)
          end)
        end
      end

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('custom-treesitter-attach', { clear = true }),
        callback = function(args)
          attach(args.buf)
        end,
      })

      -- Attach to any buffers that were already loaded before this plugin ran.
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) then
          attach(buf)
        end
      end
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-treesitter-textobjects').setup {
        select = {
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          -- You can choose the select mode (default is charwise 'v')
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V', -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
          -- Extend any textobject to include preceding/succeeding whitespace,
          -- so it behaves similarly to the built-in `ap`.
          include_surrounding_whitespace = true,
        },
      }

      -- On the `main` branch keymaps are registered manually rather than via opts.
      local select = require 'nvim-treesitter-textobjects.select'
      local function map(key, query, group, desc)
        vim.keymap.set({ 'x', 'o' }, key, function()
          select.select_textobject(query, group)
        end, { desc = desc })
      end

      -- You can use the capture groups defined in `textobjects.scm`
      map('af', '@function.outer', 'textobjects', 'Select outer part of a function region')
      map('if', '@function.inner', 'textobjects', 'Select inner part of a function region')
      map('ac', '@class.outer', 'textobjects', 'Select outer part of a class region')
      map('ic', '@class.inner', 'textobjects', 'Select inner part of a class region')
      -- You can also use captures from other query groups like `locals.scm`
      map('as', '@local.scope', 'locals', 'Select language scope')
    end,
  },
}
