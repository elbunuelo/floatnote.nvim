local GROUP = {
  daily = 'daily',
  weekly = 'weekly'
}

vim.api.nvim_create_user_command("FloatDaily", function()
  require("floatnote").open_note(GROUP.daily)
end, {})

vim.api.nvim_create_user_command("FloatWeekly", function()
  require("floatnote").open_note(GROUP.weekly)
end, {})

vim.api.nvim_create_user_command("FloatPick", function()
  require("floatnote").pick_note()
end, {})

vim.api.nvim_set_keymap('n', '<leader>Nd', ':FloatDaily<CR>', { desc = 'Open daily note in floating window.' })
vim.api.nvim_set_keymap('n', '<leader>Nw', ':FloatWeekly<CR>', { desc = 'Open weekly note in floating window.' })
vim.api.nvim_set_keymap('n', '<leader>No', ':FloatPick<CR>', { desc = 'Pick a note and open it in a floating window.' })
