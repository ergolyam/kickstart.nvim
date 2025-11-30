-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'Mofiqul/vscode.nvim',
    priority = 1000,
    config = function()
      vim.o.termguicolors = true
      require('vscode').setup {
        transparent = false,
        italic_comments = false,
        underline_links = true,
      }
      require('vscode').load 'dark'
    end,
  },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
    },
    config = function()
      require('telescope').load_extension 'file_browser'
      vim.keymap.set('n', '<leader>fb', function()
        require('telescope').extensions.file_browser.file_browser()
      end, { desc = 'Telescope File Browser' })
    end,
  },
  {
    'Wansmer/langmapper.nvim',
    lazy = false,
    priority = 1,
    config = function()
      require('langmapper').setup { global = true, buffer = true }
      local function escape(str)
        local escape_chars = [[;,."|\]]
        return vim.fn.escape(str, escape_chars)
      end
      local en = [[`qwertyuiop[]asdfghjkl;'zxcvbnm]]
      local ru = [[ёйцукенгшщзхъфывапролджэячсмить]]
      local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
      local ru_shift = [[ËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]]
      vim.opt.langmap = vim.fn.join({
        escape(ru_shift) .. ';' .. escape(en_shift),
        escape(ru) .. ';' .. escape(en),
      }, ',')
    end,
  },
  {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup { mappings = {} }
      neoscroll = require 'neoscroll'
      local keymap = {
        ['<C-u>'] = function()
          neoscroll.ctrl_u { duration = 250 }
        end,
        ['<C-d>'] = function()
          neoscroll.ctrl_d { duration = 250 }
        end,
        ['<C-b>'] = function()
          neoscroll.ctrl_b { duration = 450 }
        end,
        ['<C-f>'] = function()
          neoscroll.ctrl_f { duration = 450 }
        end,
        ['<C-y>'] = function()
          neoscroll.scroll(-0.1, { move_cursor = false, duration = 100 })
        end,
        ['<C-e>'] = function()
          neoscroll.scroll(0.1, { move_cursor = false, duration = 100 })
        end,
        ['zt'] = function()
          neoscroll.zt { half_win_duration = 250 }
        end,
        ['zz'] = function()
          neoscroll.zz { half_win_duration = 250 }
        end,
        ['zb'] = function()
          neoscroll.zb { half_win_duration = 250 }
        end,
        ['<PageUp>'] = function()
          neoscroll.ctrl_b { duration = 450 }
        end,
        ['<PageDown>'] = function()
          neoscroll.ctrl_f { duration = 450 }
        end,
      }
      local modes = { 'n', 'v', 'x', 'i', 's' }
      for key, func in pairs(keymap) do
        vim.keymap.set(modes, key, func)
      end
    end,
  },
  { 'windwp/nvim-autopairs', event = 'InsertEnter', config = true },
}
