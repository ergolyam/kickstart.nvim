return {
  vim.keymap.set('n', '<leader>lg', function()
    local dir = vim.fn.expand '%:p:h'
    local old_dir = vim.fn.getcwd()
    if dir == '' then
      dir = vim.fn.getcwd()
    end
    vim.cmd('lcd ' .. vim.fn.fnameescape(dir))
    vim.cmd 'term lazygit'
    vim.cmd('lcd ' .. vim.fn.fnameescape(old_dir))
    local buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_name(buf, 'lazygit')
    vim.cmd 'startinsert'
  end, { desc = 'Open lazygit' }),

  vim.api.nvim_create_autocmd('TermClose', {
    pattern = 'lazygit',
    callback = function()
      vim.cmd 'bd!'
    end,
  }),

  vim.keymap.set({ 'n', 'v' }, '<C-s>', '<cmd>w<CR>', { desc = 'Save file' }),
  vim.keymap.set('i', '<C-s>', '<Esc><cmd>w<CR>', { desc = 'Save file' }),
}
