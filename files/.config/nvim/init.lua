require('plugins')

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.clipboard = "unnamedplus"

vim.cmd [[colorscheme rdark-terminal2]]

local map = require("utils").map

map("i", "jj", "<Esc>")
map("t", "jj", "<C-\\><C-n>")

map("n", "<Leader>s", ":update<CR>", { silent = true })
map("i", "<Leader>s", "<C-O>:update<CR>", { silent = true })

map("n", "<A-h>", "<C-w>h") 
map("n", "<A-j>", "<C-w>j") 
map("n", "<A-k>", "<C-w>k") 
map("n", "<A-l>", "<C-w>l") 
map("i", "<A-h>", "<C-\\><C-N><C-w>h") 
map("i", "<A-j>", "<C-\\><C-N><C-w>j") 
map("i", "<A-k>", "<C-\\><C-N><C-w>k") 
map("i", "<A-l>", "<C-\\><C-N><C-w>l") 
map("v", "<A-h>", "<Esc><C-w>h") 
map("v", "<A-j>", "<Esc><C-w>j") 
map("v", "<A-k>", "<Esc><C-w>k") 
map("v", "<A-l>", "<Esc><C-w>l") 
map("t", "<A-h>", "<C-\\><C-N><C-w>h") 
map("t", "<A-j>", "<C-\\><C-N><C-w>j") 
map("t", "<A-k>", "<C-\\><C-N><C-w>k") 
map("t", "<A-l>", "<C-\\><C-N><C-w>l") 

