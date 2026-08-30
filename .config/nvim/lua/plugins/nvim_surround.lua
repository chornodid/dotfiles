return {
  {
    -- surround text with quotes, brackets, etc.
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        move_cursor = false,
        -- keymaps = {
        --   visual = "",
        -- }
      })
    end,
  },
}
