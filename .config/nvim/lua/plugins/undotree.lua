return {
  {
    -- nvim.undotree ships inside Neovim itself (pack/dist/opt), not a git
    -- repo, so there's nothing for lazy.nvim to clone; this just wires the
    -- native `:packadd` into the normal lazy-loading/keymap system.
    dir = vim.env.VIMRUNTIME,
    name = "nvim.undotree",
    keys = {
      {
        "<leader>uu",
        function()
          vim.cmd.packadd("nvim.undotree")
          require("undotree").open()
        end,
        desc = "Undo Tree",
      },
    },
  },
}
