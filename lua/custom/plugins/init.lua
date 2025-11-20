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
}
