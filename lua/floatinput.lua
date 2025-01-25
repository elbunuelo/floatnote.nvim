local M = {}

M.input_title = function(cb)
  -- Create a buffer for the floating window
  local buf = vim.api.nvim_create_buf(false, true)

  -- Get the current UI dimensions
  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")

  -- Define floating window dimensions
  local win_width = 40
  local win_height = 1

  -- Calculate window position
  local row = math.floor((height - win_height) / 2)
  local col = math.floor((width - win_width) / 2)

  -- Configuration for the floating window
  local opts = {
    style = "minimal",
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col,
    border = "rounded",
    title = {
      { "Note title", "FloatTitle" },
    },
  }

  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, true, opts)

  -- Enter insert mode in the new window
  vim.cmd("startinsert")

  local on_capture_input = function()
    vim.cmd("stopinsert")
    -- Get the input from the floating window
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local input = lines[1] or ""
    -- Close the floating window
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_close(win, true)

    -- Do something with the input (example: print it)
    cb(input)
  end

  -- Set up a key mapping to capture the input
  vim.keymap.set("i", "<CR>", on_capture_input, { noremap = true, silent = true, buffer = buf })

  local close_window = function()
    pcall(vim.api.nvim_win_close, win, true)
  end

  vim.keymap.set("i", "<Esc>", close_window, { noremap = true, silent = true, buffer = buf })
end

return M
