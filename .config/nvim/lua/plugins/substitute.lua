return {
  {
    "gbprod/substitute.nvim",
    enabled = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local substitute = require("substitute")
      substitute.setup()

      -- set keymaps
      local keymap = vim.keymap -- for conciseness
      keymap.set("n", "s", substitute.operator, { desc = "Substitute with motion", noremap = true })
      keymap.set("n", "ss", substitute.line, { desc = "Substitute line", noremap = true })
      keymap.set("n", "S", substitute.eol, { desc = "Substitute to end of line", noremap = true })
      keymap.set("x", "s", substitute.visual, { desc = "Substitute in visual mode", noremap = true })
    end,
  },
}
