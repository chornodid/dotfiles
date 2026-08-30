-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt
local vg = vim.g
local vo = vim.o

vg.autoformat = false
opt.softtabstop = 2
opt.autoindent = true
opt.updatetime = 50
opt.colorcolumn = "80,100,120"

vo.foldcolumn = "1"
vo.foldlevel = 99
vo.foldlevelstart = 99
vo.foldenable = true
vo.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
