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

      -- on_attach = function(buffer)
      --   local gs = package.loaded.gitsigns
      --
      --   local function map(mode, l, r, desc)
      --     vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      --   end
      --   -- customize keymaps
      --   map("n", "]h", gs.next_hunk, "Next Hunk")
      --   map("n", "<leader>ghn", gs.next_hunk, "Next Hunk")
      --   map("n", "[h", gs.prev_hunk, "Prev Hunk")
      --   map("n", "<leader>ghp", gs.prev_hunk, "Prev Hunk")
      --   map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
      --   map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
      --   map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
      --   map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
      --   map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
      --   map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
      --   map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
      --   map("n", "<leader>gb", gs.toggle_current_line_blame, "Toggle Line Blame")
      --   map("n", "<leader>ghd", gs.diffthis, "Diff This")
      --   map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
      --   map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      -- end,
    },
  },
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>gd", "<cmd>DiffviewToggle<CR>", desc = "Toggle Diff Viewer" },
    },
  },
}
