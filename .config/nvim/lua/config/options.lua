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

-- auto-session needs this to correctly restore per-window local options
opt.sessionoptions:append("localoptions")

-- Unused remote-plugin hosts (nothing in this config or its plugins needs them); silences checkhealth noise
vg.loaded_node_provider = 0
vg.loaded_perl_provider = 0
vg.loaded_python3_provider = 0
vg.loaded_ruby_provider = 0

-- Over SSH, LazyVim leaves the system clipboard alone. Copy to the local machine's clipboard via
-- OSC 52 anyway, but paste from Neovim's own register: terminals like Alacritty refuse OSC 52 reads,
-- which would make every `p` hang. Paste from the local clipboard with the terminal's paste key.
if vim.env.SSH_TTY then
  local osc52 = require("vim.ui.clipboard.osc52")
  local function paste()
    return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
  end
  vg.clipboard = {
    name = "OSC 52 (copy only)",
    copy = { ["+"] = osc52.copy("+"), ["*"] = osc52.copy("*") },
    paste = { ["+"] = paste, ["*"] = paste },
  }
  opt.clipboard = "unnamedplus"
end
