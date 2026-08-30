return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    size = 20,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_terminals = true,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    direction = "horizontal", -- or "vertical", "float", "tab"
    close_on_exit = true,
    shell = vim.o.shell,
  },
  keys = {
    { "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
    { "<C-\\>", "<cmd>ToggleTerm<cr>", mode = "t", desc = "Toggle terminal" },
  },
}
