-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt
opt.spelllang = { "en", "cjk" }
opt.spell = false -- Not enable spell checking
opt.spellfile = vim.fn.stdpath("config") .. "/nvim/spell/zh.utf-8.add" -- Custom spell file
