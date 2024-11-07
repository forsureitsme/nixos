local builtin = require('telescope.builtin')

vim.g.mapleader = " "
vim.keymap.set('n', '-', vim.cmd.Ex)
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})        

local fm = require('fluoromachine')

fm.setup {
  glow = false,
  theme = 'fluoromachine',
  transparent = false,
}

vim.cmd.colorscheme 'fluoromachine'
