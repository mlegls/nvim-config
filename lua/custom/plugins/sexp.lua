local lisp_ft = { 'clojure', 'fennel', 'scheme', 'lisp', 'commonlisp', 'racket', 'hy', 'janet', 'yuck' }

return {
  -- parinfer-rust ships a native library that must be compiled; without this
  -- `build` step the dylib is missing and it errors on every lisp buffer.
  { 'eraserhd/parinfer-rust', ft = lisp_ft, build = 'cargo build --release' },
  { 'guns/vim-sexp', ft = lisp_ft },
  { 'tpope/vim-sexp-mappings-for-regular-people', ft = lisp_ft },
  {
    'Olical/conjure',
    ft = { 'clojure', 'fennel', 'hy', 'python', 'lua', 'julia', 'rust' }, -- etc
    lazy = true,
    init = function()
      vim.g['conjure#mapping#doc_word'] = false
      -- Set configuration options here
      -- Uncomment this to get verbose logging to help diagnose internal Conjure issues
      -- This is VERY helpful when reporting an issue with the project
      -- vim.g["conjure#debug"] = true
    end,
    -- NOTE: the optional cmp-conjure integration was removed — this config uses
    -- COQ for completion, so the nvim-cmp conjure source was dead weight (and
    -- pulled nvim-cmp back in, erroring with "module 'cmp' not found").
  },

  -- langs
  { 'hylang/vim-hy', ft = 'hy' },
}
