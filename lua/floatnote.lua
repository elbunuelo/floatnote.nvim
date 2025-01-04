local api = require("zk.api")

local M = {}

local function open_floating_window()
  -- Calculate window dimensions and position
  local width = 80
  local height = math.floor(0.80 * vim.o.lines)

  -- Get editor dimensions
  local editor_width = vim.o.columns
  local editor_height = vim.o.lines

  -- Calculate starting position to center the window
  local row = math.floor((editor_height - height) / 2) * 0.8
  local col = math.floor((editor_width - width) / 2)

  -- Create the floating window
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded'
  })

  return win
end

M.open_note = function(group)
  local cb = function(err, res)
    local win = open_floating_window()
    assert(not err, tostring(err))
    local note_buffer = vim.api.nvim_buf_get_number(0)
    local close_window = function()
      pcall(vim.api.nvim_win_close, win, true)
    end

    vim.cmd("edit " .. res.path)
    vim.api.nvim_create_autocmd("BufLeave", {
      buffer = note_buffer,
      callback = close_window
    });
    vim.keymap.set('n', 'q', close_window, { buffer = note_buffer })
  end

  api.new(nil, { group = group, edit = true }, cb)
end

M.pick_note = function()
  local cb = function(notes)
    local win = open_floating_window()
    local note_buffer = vim.api.nvim_buf_get_number(0)
    local close_window = function()
      pcall(vim.api.nvim_win_close, win, true)
    end

    vim.cmd("edit " .. notes[1].absPath)
    vim.api.nvim_create_autocmd("BufLeave", {
      buffer = note_buffer,
      callback = close_window
    });
    vim.keymap.set('n', 'q', close_window, { buffer = note_buffer })
  end
  local zk = require("zk")

  zk.pick_notes({ sort = { 'modified' } }, {}, cb)
end

return M
