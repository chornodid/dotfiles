return {
  {
    "stevearc/oil.nvim",
    enabled = true,
    tag = "v2.7.0",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        use_default_keymaps = true,
        keymaps = {
          -- Disabled: single keystrokes, too easy to hit by accident while
          -- browsing, and they silently change Neovim's cwd (` = :cd,
          -- ~ = :tcd) which broke path-relative logic elsewhere in this config.
          ["`"] = false,
          ["~"] = false,
        },
        -- keymaps = {
        --   -- default
        --   -- ["<CR>"] = "actions.select",
        --   -- ["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
        --   -- ["<C-h>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
        --   -- ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
        --   -- ["<C-p>"] = "actions.preview",
        --   -- ["<C-c>"] = "actions.close",
        --   -- ["<C-l>"] = "actions.refresh",
        --   -- ["-"] = "actions.parent",
        --   -- ["_"] = "actions.open_cwd",
        --   -- ["`"] = "actions.cd",
        --   -- ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
        --   -- ["gs"] = "actions.change_sort",
        --   -- ["gx"] = "actions.open_external",
        --   -- ["g."] = "actions.toggle_hidden",
        --   -- ["g\\"] = "actions.toggle_trash",
        --
        --   ["<leader>-"] =  { "actions.parent", desc = "Open parent directory" },
        --   ["<leader>_"] =  { "actions.open_cwd", desc = "Open CWD" },
        --   ["<leader>q"] =  { "actions.close", desc = "Close" },
        --   ["<cr>"] =       { "actions.select", opts = { close = true }, desc = "Open" },
        --   ["<leader>w-"] = { "actions.select", opts = { horizontal = true }, desc = "Open in horizontal split" },
        --   ["<leader>w|"] = { "actions.select", opts = { vertical = true }, desc = "Open in vertical split" },
        --   ["<leader>p"] =  { "actions.preview", desc = "Open/Close Preview"},
        --   ["<leader>r"] =  { "actions.refresh", desc = "refresh current directory" },
        --   ["<leader>yy"] = { "actions.yank_entry", desc = "Yank path" },
        -- },
        delete_to_trash = true,
        view_options = {
          show_hidden = true,
          natural_order = true,
        },
        columns = {
          "icon",
          "size",
          -- "mtime",
        },
      })

      vim.keymap.set("n", "<leader>o", "<cmd>Oil<cr>", { desc = "(Oil) Open parent directory" })
    end,
  },
}
