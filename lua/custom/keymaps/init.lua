return {
  vim.keymap.set('n', '<leader>lg', function()
    vim.cmd 'term lazygit'
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
}
