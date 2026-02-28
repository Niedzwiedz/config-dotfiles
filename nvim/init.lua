-- set up Lua options
local home_dir = os.getenv("HOME") -- get the user's home directory
package.path = home_dir .. "/.config/nvim/base/?.lua;" .. package.path -- extend Lua's package path
require "options" -- load custom options
require "keybindings" -- load custom keybindings
require "global" -- load global variables or settings
require "registers" -- load custom registers

-- automatically remove trailing whitespace on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" }, -- apply to all file types
  command = [[%s/\s\+$//e]], -- remove trailing whitespace
})

-- set up lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim" -- define the path for lazy.nvim
if not vim.loop.fs_stat(lazypath) then -- check if lazy.nvim is not installed
  vim.fn.system({
    "git", -- use git to clone the repository
    "clone",
    "--filter=blob:none", -- clone only necessary files
    "https://github.com/folke/lazy.nvim.git", -- repository URL
    "--branch=stable", -- use the latest stable release
    lazypath, -- clone to the defined path
  })
end

vim.opt.rtp:prepend(lazypath) -- prepend lazy.nvim to runtime path

require("lazy").setup("plugins") -- load plugins using lazy.nvim
