return {
  -- symbol outline viewer (base plugin/keymap/icons come from the
  -- lazyvim.plugins.extras.editor.outline extra; this just layers our
  -- own window/item preferences and keymap on top)
  {
    "hedyhli/outline.nvim",
    keys = { { "<leader>co", "<cmd>Outline<cr>", desc = "Toggle Outline" } },
    opts = {
      outline_window = {
        auto_close = false,
        auto_jump = true,
      },
      outline_items = {
        show_symbol_lineno = true,
      },
    },
  },
}
