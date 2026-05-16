-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- vim.opt.number = true
-- vim.opt.relativenumber = true
-- vim.opt.clipboard = "unnamedplus"
-- vim.opt.termguicolors = true
-- vim.opt.signcolumn = "yes"
-- vim.opt.updatetime = 200
-- vim.opt.timeoutlen

--  vim.g.dbs = {
--  postgres_local = "postgres://user:senha@localhost:5432/meubanco",
--}

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.wrap = false

-- Indentação
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

-- Busca
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Performance
opt.updatetime = 50
opt.timeoutlen = 300
opt.lazyredraw = false

-- Scroll
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Split
opt.splitright = true
opt.splitbelow = true

-- Clipboard
opt.clipboard = "unnamedplus"

-- Backup / undo
opt.swapfile = false
opt.backup = false
opt.undofile = true

-- Aparência do cursor
opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20"

-- Espaços invisíveis
opt.list = true
opt.listchars = {
  tab = "» ",
  trail = "·",
  nbsp = "␣",
}

-- Completação melhor
opt.completeopt = { "menu", "menuone", "noselect" }

-- Mouse
opt.mouse = "a"
