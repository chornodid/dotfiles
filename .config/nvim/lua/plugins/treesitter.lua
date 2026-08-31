return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- LazyVim core sets opts_extend = { "ensure_installed" }, so this list is
    -- merged with (not a replacement for) its own list, not the full set of
    -- installed parsers. Only list languages not already in LazyVim core's
    -- default ensure_installed.
    opts = {
      ensure_installed = {
        "ruby",
      },
    },
  },

  -- Split or join treesitter nodes
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter" },
    opts = { use_default_keymaps = false },
    keys = {
      { "<leader>tt", "<Cmd>TSJToggle<CR>", desc = "Treesj: Toggle Node Under Cursor" },
      { "<leader>ts", "<Cmd>TSJSplit<CR>", desc = "Treesj: Split Node Under Cursor" },
      { "<leader>tj", "<Cmd>TSJJoin<CR>", desc = "Treesj: Join Node Under Cursor" },
    },
  },

  -- Navigate/swap treesitter nodes (siblings), regardless of language
  {
    "aaronik/treewalker.nvim",
    opts = { highlight = true },
    keys = {
      { "]n", "<cmd>Treewalker Down<cr>", desc = "Next Node", mode = { "n", "v" } },
      { "[n", "<cmd>Treewalker Up<cr>", desc = "Previous Node", mode = { "n", "v" } },
      { "<leader>cj", "<cmd>Treewalker SwapDown<cr>", desc = "Swap Node Down", mode = { "n", "v" } },
      { "<leader>ck", "<cmd>Treewalker SwapUp<cr>", desc = "Swap Node Up", mode = { "n", "v" } },
    },
  },
}
