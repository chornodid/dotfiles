-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local km = vim.keymap
local nset = function(...)
  km.set("n", ...)
end
local vset = function(...)
  km.set("v", ...)
end
local iset = function(...)
  km.set("i", ...)
end

iset("jj", "<ESC>", { silent = true })

-- Zoom only needs one key; drop the LazyVim default's second binding
vim.keymap.del("n", "<leader>wm")

--  Buffer Navigation
nset("<leader>bn", ":bnext<CR>", { desc = "Next Buffer", silent = true })
nset("<leader>bp", ":bprev<CR>", { desc = "Previous Buffer", silent = true })

-- Copy the relative/full path of the current buffer
local function copy_relative_path()
  local relative_path = vim.fn.expand("%")
  vim.fn.setreg("+", relative_path)
  vim.notify("Copied relative path to clipboard: " .. relative_path)
end

local function copy_full_path()
  local full_path = vim.fn.expand("%:p")
  vim.fn.setreg("+", full_path)
  vim.notify("Copied full path to clipboard: " .. full_path)
end

nset("<leader>fy", copy_relative_path, { desc = "Copy Relative Path" })
nset("<leader>fY", copy_full_path, { desc = "Copy Full Path" })

nset(
  "<leader>tgu",
  [[<Cmd> lua require("config.utils").open_test_file_for_source_file("unit")<CR>]],
  { desc = "Open unit test file" }
)
nset(
  "<leader>tgi",
  [[<Cmd> lua require("config.utils").open_test_file_for_source_file("integration")<CR>]],
  { desc = "Open integration test file" }
)
nset(
  "<leader>tgs",
  [[<Cmd> lua require("config.utils").open_source_file_for_test_file()<CR>]],
  { desc = "Open source file of the test file" }
)

nset("<leader>qs", ":AutoSession save<cr>", { noremap = true, desc = "(auto-sessions) Save" })
nset("<leader>qd", ":AutoSession delete<cr>", { noremap = true, desc = "(auto-sessions) Delete" })
nset("<leader>qr", ":AutoSession restore<cr>", { noremap = true, desc = "(auto-sessions) Restore" })
nset("<leader>qp", ":AutoSession purgeOrphaned<cr>", { noremap = true, desc = "(auto-sessions) Purge Orphaned" })
