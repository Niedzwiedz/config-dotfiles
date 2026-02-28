vim.api.nvim_create_augroup("RubyRegisters", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = "RubyRegisters",
  pattern = { "ruby", "rake" },
  callback = function()
    -- @l - log - puts visual selection on new line
    vim.fn.setreg("l", "yoputs(\"pa: #{pa}\")")
  end,
})

vim.api.nvim_create_augroup("ShitScriptRegisters", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = "ShitScriptRegisters",
  pattern = { "javascript", "typescript" },
  callback = function()
    -- @l - log -  console.log visual selection on new line
    vim.fn.setreg("l", "yoconsole.log(\"pa:\", pa\")")
  end,
})

