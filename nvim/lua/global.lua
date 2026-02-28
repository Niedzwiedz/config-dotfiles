-- disable netrw (default file explorer) to use a custom file explorer plugin
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.enable_bold_font = 1
vim.g.enable_italic_font = 1

P = function(v)
  print(vim.inspect(v))
  return v
end
