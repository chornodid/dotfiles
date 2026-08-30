return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- rubocop is enabled via ruby-lsp
        rubocop = false,
      },
    },
  },
}
