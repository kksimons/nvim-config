-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Prevent number keys from being interpreted as count prefixes
vim.keymap.set("n", "1", "<Nop>", { desc = "Disable 1 as count" })
vim.keymap.set("n", "2", "<Nop>", { desc = "Disable 2 as count" })

vim.keymap.set("n", "<C-Up>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("n", "<C-Down>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<C-S-Up>", "yyp", { desc = "Duplicate line below" })