return {
  { 'Apeiros-46B/uiua.vim', ft = 'uiua' },
  {
    'mlochbaum/BQN',
    ft = 'bqn',
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. '/editors/vim')
      require('lazy.core.loader').packadd(plugin.dir .. '/editors/vim')
    end,
    init = function(plugin)
      require('lazy.core.loader').ftdetect(plugin.dir .. '/editors/vim')
    end,
  },
  { 'calebowens/nvim-bqn', ft = 'bqn' },
}
