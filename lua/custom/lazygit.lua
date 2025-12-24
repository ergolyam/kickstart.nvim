local M = {}

local lazygit_float = { win = nil, buf = nil }

function M.open()
  if lazygit_float.win and vim.api.nvim_win_is_valid(lazygit_float.win) then
    vim.api.nvim_win_close(lazygit_float.win, true)
    lazygit_float.win = nil
  end
  if lazygit_float.buf and vim.api.nvim_buf_is_valid(lazygit_float.buf) then
    pcall(vim.api.nvim_buf_delete, lazygit_float.buf, { force = true })
    lazygit_float.buf = nil
  end

  local dir = vim.fn.expand '%:p:h'
  if dir == '' then
    dir = vim.fn.getcwd()
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(buf, 'lazygit')
  vim.bo[buf].bufhidden = 'wipe'

  local cur_win = 0
  local win_w = vim.api.nvim_win_get_width(cur_win)
  local win_h = vim.api.nvim_win_get_height(cur_win)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'win',
    win = cur_win,
    width = win_w,
    height = win_h,
    col = 0,
    row = 0,
    style = 'minimal',
    border = 'none',
  })

  lazygit_float.buf = buf
  lazygit_float.win = win

  vim.fn.termopen('lazygit', { cwd = dir })

  vim.api.nvim_create_autocmd('TermClose', {
    buffer = buf,
    once = true,
    callback = function()
      if lazygit_float.win and vim.api.nvim_win_is_valid(lazygit_float.win) then
        pcall(vim.api.nvim_win_close, lazygit_float.win, true)
      end
      lazygit_float.win, lazygit_float.buf = nil, nil
      if vim.api.nvim_buf_is_valid(buf) then
        pcall(vim.api.nvim_buf_delete, buf, { force = true })
      end
    end,
  })

  vim.cmd 'startinsert'
end

return M
