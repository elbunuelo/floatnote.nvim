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

vim.api.nvim_set_keymap('n', '<leader>Nd', ':FloatDaily<CR>', { desc = 'Open daily note in floating window.' })
vim.api.nvim_set_keymap('n', '<leader>Nw', ':FloatWeekly<CR>', { desc = 'Open weekly note in floating window.' })
