return {
  -- Features:
  --   Signs for added, removed, and changed lines
  --   Asynchronous using luv
  --   Navigation between hunks
  --   Stage hunks (with undo)
  --   Preview diffs of hunks (with word diff)
  --   Customizable (signs, highlights, mappings, etc)
  --   Status bar integration
  --   Git blame a whole buffer or a specific line.
  --   Hunk text object
  --   Automatically follow files moved in the index.
  --   Live intra-line word diff
  --   Ability to display deleted/changed lines via virtual lines.
  --   Support for detached working trees.
  {
    "lewis6991/gitsigns.nvim",
    enabled = true,
    event = "LazyFile",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 2000,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
    },
  },
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>gd", "<cmd>DiffviewToggle<CR>", desc = "Toggle Diff Viewer" },
    },
  },
}
