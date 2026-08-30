-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
local autocmd = vim.api.nvim_create_autocmd

-- Remove trailing whitespace on save (markdown excluded: trailing spaces are a hard line break there)
autocmd("BufWritePre", {
  callback = function()
    if vim.bo.filetype == "markdown" then
      return
    end
    vim.cmd([[%s/\s\+$//e]])
  end,
  pattern = "*",
})
