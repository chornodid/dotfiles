local M = {}

function M.buffer_location_lines()
  local total_lines = vim.api.nvim_buf_line_count(0)
  local current_line, _ = unpack(vim.api.nvim_win_get_cursor(0))
  return current_line .. "/" .. total_lines
end

function M.unique_list(list)
  local unique_set = {}
  local unique_list = {}
  for _, value in ipairs(list) do
    if not unique_set[value] then
      unique_set[value] = true
      table.insert(unique_list, value)
    end
  end
  return unique_list
end

function M.loaded_file_buffers()
  local buffers = vim.api.nvim_list_bufs()
  local loaded_file_buffers = {}

  for _, buf_number in ipairs(buffers) do
    if
      vim.api.nvim_buf_is_loaded(buf_number)
      and vim.api.nvim_get_option_value("buftype", { buf = buf_number }) == ""
    then
      table.insert(loaded_file_buffers, buf_number)
    end
  end

  return loaded_file_buffers
end

function M.current_tab_loaded_file_buffers()
  local tab_number = vim.api.nvim_get_current_tabpage()
  local current_tab_windows = vim.api.nvim_tabpage_list_wins(tab_number)
  local loaded_file_buffers = {}

  for _, win in ipairs(current_tab_windows) do
    local buf_number = vim.api.nvim_win_get_buf(win)
    if vim.api.nvim_get_option_value("buftype", { buf = buf_number }) == "" then
      table.insert(loaded_file_buffers, buf_number)
    end
  end

  return M.unique_list(loaded_file_buffers)
end

-- Find the git project root by walking up from the given absolute path.
-- Matches ".git" as either a directory (regular clone) or a file
-- (git worktree, which stores a "gitdir: ..." pointer instead), so
-- worktrees resolve to their own root just like a regular checkout.
local function find_git_root(path)
  return vim.fs.root(path, ".git")
end

-- In Rails, find unit/integration test file for the current source file
function M.find_test_file(type)
  local current_full_path = vim.fn.expand("%:p")
  local root = find_git_root(current_full_path)
  if not root then
    vim.notify("Could not find git root (.git) for the current file", vim.log.levels.ERROR)
    return
  end
  local current_relative_path = current_full_path:sub(#root + 2)
  local test_relative_path = nil

  if not string.match(current_relative_path, ".rb$") then
    vim.notify("Not a Ruby file!", vim.log.levels.WARN)
    return
  elseif string.match(current_relative_path, "^app/") then
    test_relative_path = string.gsub(current_relative_path, "^app/(.*)%.rb$", "spec/" .. type .. "/%1_spec.rb")
  elseif string.match(current_relative_path, "^lib/") then
    test_relative_path = string.gsub(current_relative_path, "^lib/(.*)%.rb$", "spec/" .. type .. "/%1_spec.rb")
  else
    vim.notify("Unrecognized Rails top level dir!", vim.log.levels.ERROR)
    return
  end

  if not test_relative_path then
    return
  end
  local test_full_path = root .. "/" .. test_relative_path
  local file = io.open(test_full_path, "r")
  if file then
    file:close()
    return test_full_path
  else
    vim.notify("Was not able to find test file: " .. test_relative_path, vim.log.levels.WARN)
    return
  end
end

-- In Rails, find source file for the current unit/integration test file
function M.find_source_file_for_test_file()
  local current_full_path = vim.fn.expand("%:p")
  local root = find_git_root(current_full_path)
  if not root then
    vim.notify("Could not find git root (.git) for the current file", vim.log.levels.ERROR)
    return
  end
  local current_relative_path = current_full_path:sub(#root + 2)
  local source_relative_path = nil

  if not string.match(current_relative_path, "^spec/.+_spec.rb$") then
    vim.notify("Not an RSpec file!", vim.log.levels.WARN)
    return
  elseif string.match(current_relative_path, "^spec/integration/") then
    source_relative_path = string.gsub(current_relative_path, "^spec/integration/(.+)_spec.rb$", "%1.rb")
  elseif string.match(current_relative_path, "^spec/unit/") then
    source_relative_path = string.gsub(current_relative_path, "^spec/unit/(.+)_spec.rb$", "%1.rb")
  else
    vim.notify("Unrecognized RSpec top level dir!", vim.log.levels.ERROR)
    return
  end

  -- try to find the file in app or lib directory
  local app_full_path = root .. "/app/" .. source_relative_path
  local lib_full_path = root .. "/lib/" .. source_relative_path

  local file = io.open(app_full_path, "r")
  if file then
    file:close()
    return app_full_path
  end

  file = io.open(lib_full_path, "r")
  if file then
    file:close()
    return lib_full_path
  end

  vim.notify("Unable to find source file in Rails top dirs: " .. source_relative_path, vim.log.levels.WARN)
end

-- Before opening file, check if the file is already displayed
function M.activate_file_window(test_file)
  local buffers = vim.api.nvim_list_bufs()

  for _, buffer in ipairs(buffers) do
    if vim.api.nvim_buf_is_loaded(buffer) and vim.api.nvim_buf_get_name(buffer) == test_file then
      local windows = vim.api.nvim_list_wins()

      for _, window in ipairs(windows) do
        if vim.api.nvim_win_get_buf(window) == buffer then
          vim.api.nvim_set_current_win(window)
          return true
        end
      end
    end
  end

  return false
end

-- In Rails, switch from unit/integration test file to source file
function M.open_test_file_for_source_file(type)
  local test_file = M.find_test_file(type)
  if not test_file then
    return
  end

  if M.activate_file_window(test_file) then
    return
  end

  vim.cmd("edit " .. test_file)
  vim.notify("Test file opened in the current window")
end

-- In Rails, switch from source file to unit/integration test file
function M.open_source_file_for_test_file()
  local source_file = M.find_source_file_for_test_file()
  if not source_file then
    return
  end

  if M.activate_file_window(source_file) then
    return
  end

  vim.cmd("edit " .. source_file)
  vim.notify("Source file opened in the current window")
end

return M
