-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>du", "<cmd>DBUIToggle<cr>", { desc = "DB UI" })
vim.keymap.set("v", "<leader>dr", ":DB<cr>", { desc = "Run query" })

vim.keymap.set("i", "jk", "<Esc>", { desc = "Sair do insert com jk" })
