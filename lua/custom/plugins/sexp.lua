return {
  { 'eraserhd/parinfer-rust' },
  { 'guns/vim-sexp' },
  { 'vim-sexp-mappings-for-regular-people' },
  {
    'Olical/conjure',
    ft = { 'clojure', 'fennel', 'hy', 'python', 'lua', 'julia', 'rust' }, -- etc
    lazy = true,
    init = function()
      -- Set configuration options here
      -- Uncomment this to get verbose logging to help diagnose internal Conjure issues
      -- This is VERY helpful when reporting an issue with the project
      -- vim.g["conjure#debug"] = true
    end,

    -- Optional cmp-conjure integration
    dependencies = { 'PaterJason/cmp-conjure' },
  },
  {
    'PaterJason/cmp-conjure',
    lazy = true,
    init = function()
      vim.g['conjure#mapping#doc_word'] = false
    end,
    config = function()
      local cmp = require 'cmp'
      local config = cmp.get_config()
      table.insert(config.sources, { name = 'conjure' })
      return cmp.setup(config)
    end,
  },

  -- langs
  { 'hylang/vim-hy', ft = 'hy' },
}
