return {
  {
    'tidalcycles/vim-tidal',
    ft = 'tidal',
    init = function()
      vim.g.tidal_sc_enable = true
      vim.g.tidal_target = 'terminal'
    end,
  },
  { 'daveyarwood/vim-alda', ft = 'alda' },
  {
    'martineausimon/nvim-lilypond-suite',
    ft = { 'lilypond', 'ly' },
    config = function()
      require('nvls').setup {
        lilypond = {
          mappings = {
            player = '<F3>',
            compile = '<F5>',
            open_pdf = '<F6>',
            switch_buffers = '<A-Space>',
            insert_version = '<F4>',
            hyphenation = '<F12>',
            hyphenation_change_lang = '<F11>',
            insert_hyphen = '<leader>ih',
            add_hyphen = '<leader>ah',
            del_next_hyphen = '<leader>dh',
            del_prev_hyphen = '<leader>dH',
          },
          options = {
            pitches_language = 'default',
            hyphenation_language = 'en_DEFAULT',
            output = 'pdf',
            backend = nil,
            main_file = 'main.ly',
            main_folder = '%:p:h',
            include_dir = nil,
            diagnostics = false,
            pdf_viewer = nil,
          },
        },
        latex = {
          mappings = {
            compile = '<F5>',
            open_pdf = '<F6>',
            lilypond_syntax = '<F3>',
          },
          options = {
            lilypond_book_flags = nil,
            clean_logs = false,
            main_file = 'main.tex',
            main_folder = '%:p:h',
            include_dir = nil,
            lilypond_syntax_au = 'BufEnter',
            pdf_viewer = nil,
          },
        },
        texinfo = {
          mappings = {
            compile = '<F5>',
            open_pdf = '<F6>',
            lilypond_syntax = '<F3>',
          },
          options = {
            lilypond_book_flags = '--pdf',
            clean_logs = false,
            main_file = 'main.texi',
            main_folder = '%:p:h',
            lilypond_syntax_au = 'BufEnter',
            pdf_viewer = nil,
          },
        },
        player = {
          mappings = {
            quit = 'q',
            play_pause = 'p',
            loop = '<A-l>',
            backward = 'h',
            small_backward = '<S-h>',
            forward = 'l',
            small_forward = '<S-l>',
            decrease_speed = 'j',
            increase_speed = 'k',
            halve_speed = '<S-j>',
            double_speed = '<S-k>',
          },
          options = {
            row = 1,
            col = '99%',
            width = '37',
            height = '1',
            border_style = 'single',
            winhighlight = 'Normal:Normal,FloatBorder:Normal',
            midi_synth = 'fluidsynth',
            fluidsynth_flags = nil,
            timidity_flags = nil,
            audio_format = 'mp3',
            mpv_flags = {
              '--msg-level=cplayer=no,ffmpeg=no,alsa=no',
              '--loop',
              '--config-dir=/dev/null',
            },
          },
        },
      }
    end,
  },
  {
    'davidgranstrom/scnvim',
    ft = { 'sclang', 'scd' },
    config = function()
      local scnvim = require 'scnvim'
      local map = scnvim.map
      local map_expr = scnvim.map_expr
      scnvim.setup {
        keymaps = {
          ['<localleader>ee'] = map('editor.send_line', { 'i', 'n' }),
          ['<localleader>er'] = {
            map('editor.send_block', { 'i', 'n' }),
            map('editor.send_selection', 'x'),
          },
          ['<CR>'] = map 'postwin.toggle',
          ['<M-CR>'] = map('postwin.toggle', 'i'),
          ['<M-L>'] = map('postwin.clear', { 'n', 'i' }),
          ['<C-k>'] = map('signature.show', { 'n', 'i' }),
          ['<F12>'] = map('sclang.hard_stop', { 'n', 'x', 'i' }),
          ['<localleader>st'] = map 'sclang.start',
          ['<localleader>sk'] = map 'sclang.recompile',
          ['<F1>'] = map_expr 's.boot',
          ['<F2>'] = map_expr 's.meter',
          ['<F3>'] = map(function()
            require('telescope').extensions.scdoc.scdoc()
          end, { 'n', 'x', 'i' }),
          ['<localleader>sd'] = map(function()
            require('telescope').extensions.supercollider.sc_definitions()
          end, { 'n', 'x', 'i' }),
        },
        editor = {
          highlight = {
            color = 'IncSearch',
          },
        },
        postwin = {
          float = {
            enabled = true,
          },
        },
        -- extensions = {
        --   ['fzf-sc'] = {
        --     search_plugin = 'nvim-telescope/telescope.nvim',
        --   },
        -- },
      }
    end,
  },
  -- {
  --   'madskjeldgaard/nvim-supercollider-piano',
  --   dependencies = { 'davidgranstrom/scnvim' },
  --   config = function()
  --     require('scnvim').load_extension 'piano'
  --   end,
  -- },
  -- {
  --   'madskjeldgaard/fzf-sc',
  --   dependencies = { 'davidgranstrom/scnvim' },
  --   config = function()
  --     require('scnvim').load_extension 'fzf-sc'
  --   end,
  -- },
  -- {
  --   'davidgranstrom/scnvim-logger',
  --   dependencies = { 'davidgranstrom/scnvim' },
  --   config = function()
  --     require('scnvim').load_extension 'logger'
  --   end,
  -- },
  -- {
  --   'davidgranstrom/scnvim-tmux',
  --   dependencies = { 'davidgranstrom/scnvim' },
  --   config = function()
  --     require('scnvim').load_extension 'tmux'
  --   end,
  -- },
}
