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
  vim.bo[buf].textwidth = 80
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

  return win
end

local open_note_in_float = function(path)
  local win = open_floating_window()
  local close_window = function()
    pcall(vim.api.nvim_win_close, win, true)
  end

  vim.cmd("edit " .. path)

  local note_buffer = vim.api.nvim_get_current_buf()
  vim.api.nvim_create_autocmd("BufLeave", {
    buffer = note_buffer,
    callback = close_window,
  })
  vim.keymap.set("n", "q", close_window, { buffer = note_buffer })
end

M.open_note = function(group)
  local cb = function(err, res)
    assert(not err, tostring(err))
    open_note_in_float(res.path)
  end
  local api = require("zk.api")

  api.new(nil, { group = group, edit = true }, cb)
end

M.pick_note = function()
  local cb = function(notes)
    open_note_in_float(notes[1].absPath)
  end
  local zk = require("zk")

  zk.pick_notes({ sort = { "modified" } }, {}, cb)
end

M.new_note = function()
  local input = require("floatinput")
  local after_create = function(err, res)
    assert(not err, tostring(err))
    open_note_in_float(res.path)
  end

  local cb = function(title)
    local api = require("zk.api")
    api.new(nil, { title = title, edit = true }, after_create)
  end

  input.input_title(cb)
end

M.last_note = function()
  local cb = function(err, notes)
    assert(not err, tostring(err))
    open_note_in_float(notes[1].absPath)
  end

  local api = require("zk.api")
  api.list(nil, { select = { "absPath" }, sort = { "modified" } }, cb)
end

return M
