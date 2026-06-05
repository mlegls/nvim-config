return {
  { -- Completion engine (replaces COQ; pure Lua, no Python backend)
    'saghen/blink.cmp',
    version = '1.*', -- track the prebuilt 1.x releases
    dependencies = { 'rafamadriz/friendly-snippets' },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' preset: <C-space> open, <C-y> accept, <C-e> cancel,
      -- <C-n>/<C-p> select, <C-b>/<C-f> scroll docs, <Tab>/<S-Tab> snippet jump.
      -- When the menu is closed, <C-y> falls through to Copilot's accept, so the
      -- two coexist.
      keymap = { preset = 'default' },

      appearance = {
        nerd_font_variant = 'mono',
      },

      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
      },
      signature = { enabled = true },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      -- Pure-Lua fuzzy matcher: no native binary to download or build, so there
      -- is nothing for nix to break (the reason we moved off COQ's Python venv).
      fuzzy = { implementation = 'lua' },
    },
    opts_extend = { 'sources.default' },
  },
}
