return {
  {
    "folke/persistence.nvim",
    enabled = false,
  },
  {
    "rmagatti/auto-session",
    enabled = true,
    lazy = false,
    config = function()
      require("auto-session").setup({
        suppressed_dirs = { "~/", "~/Desktop", "~/Downloads", "/" },
        git_use_branch_name = true,
        post_cwd_changed_cmds = {
          function()
            -- refresh lualine so the new session name is displayed in the status bar
            require("lualine").refresh()
          end,
        },
      })
    end,
  },
}
