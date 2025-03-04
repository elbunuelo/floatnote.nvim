local GROUP = {
  weekly = "weekly",
}

vim.api.nvim_create_user_command("FloatWeekly", function()
  require("floatnote").open_note(GROUP.weekly)
end, {})

vim.api.nvim_create_user_command("FloatPick", function()
  require("floatnote").pick_note()
end, {})

vim.api.nvim_create_user_command("FloatNew", function()
  require("floatnote").new_note()
end, {})

vim.api.nvim_create_user_command("FloatLast", function()
  require("floatnote").last_note()
end, {})

vim.api.nvim_set_keymap("n", "<leader>Nw", ":FloatWeekly<CR>", { desc = "Open weekly note in floating window." })
vim.api.nvim_set_keymap("n", "<leader>No", ":FloatPick<CR>", { desc = "Pick a note and open it in a floating window." })
vim.api.nvim_set_keymap("n", "<leader>Nn", ":FloatNew<CR>", { desc = "Create a new note." })
vim.api.nvim_set_keymap("n", "<leader>Nl", ":FloatLast<CR>", { desc = "Open the last note opened." })
