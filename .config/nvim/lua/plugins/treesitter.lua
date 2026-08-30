return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "ruby",
        "bash",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
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
}
