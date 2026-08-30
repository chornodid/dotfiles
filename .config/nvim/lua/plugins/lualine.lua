return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      -- PERF: we don't need this lualine require madness 🤷
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      local icons = require("lazyvim.config").icons
      vim.o.laststatus = vim.g.lualine_laststatus

      local utils = require("config.utils")

      local buffer_stats_component = {
        function()
          return #utils.loaded_file_buffers() .. ":" .. #utils.current_tab_loaded_file_buffers()
        end,
        icon = { "" },
        color = function()
          return { Snacks.util.color("Constant", "fg") }
        end,
      }

      local window_lualine_c = {
        LazyVim.lualine.root_dir(),
        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        {
          "filename",
          -- path:
          -- 0: Just the filename
          -- 1: Relative path
          -- 2: Absolute path
          -- 3: Absolute path, with tilde as the home directory
          -- 4: Filename and parent dir, with tilde as the home directory
          path = 1,
          -- do not shorten
          shorting_target = 0,
        },
        { utils.buffer_location_lines },
      }

      local window_git_diff = {
        "diff",
        symbols = {
          added = icons.git.added,
          modified = icons.git.modified,
          removed = icons.git.removed,
        },
        source = function()
          local gitsigns = vim.b.gitsigns_status_dict
          if gitsigns then
            return {
              added = gitsigns.added,
              modified = gitsigns.changed,
              removed = gitsigns.removed,
            }
          end
        end,
      }

      local window_diagnostics = {
        "diagnostics",
        -- sections = { 'error', 'warn', 'info', 'hint' },
        sections = { "error", "warn", "hint" },
        symbols = {
          error = icons.diagnostics.Error,
          warn = icons.diagnostics.Warn,
          -- info = icons.diagnostics.Info,
          hint = icons.diagnostics.Hint,
        },
      }

      local opts = {
        options = {
          theme = "auto",
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
        },
        sections = {
          lualine_a = {},
          lualine_b = { "branch" },
          lualine_c = { buffer_stats_component },
          lualine_x = {
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = function() return { Snacks.util.color("Statement", "fg") } end,
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = function() return { Snacks.util.color("Constant", "fg") } end,
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = function() return { Snacks.util.color("Debug", "fg") } end,
            },
            -- stylua: ignore
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = function() return { Snacks.util.color("Special", "fg") } end,
            },
          },
          lualine_y = {
            -- { "progress", separator = " ", padding = { left = 1, right = 0 } },
            -- { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            function()
              return " " .. os.date("%R")
            end,
          },
        },
        winbar = {
          lualine_a = { "mode" },
          lualine_b = {},
          lualine_c = window_lualine_c,
          lualine_x = {
            window_diagnostics,
            window_git_diff,
          },
          lualine_y = {},
          lualine_z = {},
        },
        inactive_winbar = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = window_lualine_c,
          lualine_x = {
            window_git_diff,
          },
          lualine_y = {},
          lualine_z = {},
        },
        -- neo-tree displays current namespace (class -> method)
        -- extensions = { "neo-tree", "lazy" },
        extensions = { "lazy" },
      }

      -- do not add trouble symbols if aerial is enabled
      -- if vim.g.trouble_lualine then
      --   local trouble = require("trouble")
      --   local symbols = trouble.statusline
      --   and trouble.statusline({
      --     mode = "symbols",
      --     groups = {},
      --     title = false,
      --     filter = { range = true },
      --     format = "{kind_icon}{symbol.name:Normal}",
      --     hl_group = "lualine_c_normal",
      --   })
      --   table.insert(opts.sections.lualine_c, {
      --     symbols and symbols.get,
      --     cond = symbols and symbols.has,
      --   })
      -- end

      return opts
    end,
  },
}
