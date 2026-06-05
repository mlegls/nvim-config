-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  -- NOTE: the nvim-cmp dependency + confirm_done integration was removed; this
  -- config uses COQ for completion, so the cmp wiring was dead and only served
  -- to pull nvim-cmp in on every InsertEnter.
  config = function()
    require('nvim-autopairs').setup {}
  end,
}
