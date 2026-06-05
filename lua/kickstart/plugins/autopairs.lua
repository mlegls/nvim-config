-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  -- NOTE: the nvim-cmp dependency + confirm_done integration was removed; this
  -- config uses blink.cmp for completion (which has its own bracket handling),
  -- so the cmp wiring was dead and only pulled nvim-cmp in on every InsertEnter.
  config = function()
    require('nvim-autopairs').setup {}
  end,
}
