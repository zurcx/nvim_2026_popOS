local M = {}

-- contadores independentes
local counts = {
  j = 0,
  k = 0,
  h = 0,
  l = 0,
}

local last_time = vim.loop.now()

local total_errors = 0
local session_start = vim.loop.now()

-- 🎯 sugestões
local function warn_jk()
  vim.notify("🤠 Usa 5j / 10j ou / 🔍", vim.log.levels.WARN)
end

local function warn_hl()
  vim.notify("🤠 Usa w/b ou f<char> ⚡", vim.log.levels.WARN)
end

vim.opt.clipboard = "unnamedplus"

vim.on_key(function(char)
  local key = vim.fn.keytrans(char)
  local now = vim.loop.now()

  -- só modo NORMAL
  if vim.api.nvim_get_mode().mode ~= "n" then
    return
  end

  -- reset leve após pausa grande
  if now - last_time > 2000 then
    counts = { j = 0, k = 0, h = 0, l = 0 }
  end

  last_time = now

  -- só monitora essas teclas
  if not counts[key] then
    return
  end

  -- incrementa apenas a tecla usada
  counts[key] = counts[key] + 1

  -- 🔥 j/k (FUNCIONA SEMPRE)
  if (key == "j" or key == "k") and counts[key] >= 15 then
    total_errors = total_errors + 1

    warn_jk()
    vim.cmd("sleep 800m")

    counts[key] = 0
  end

  -- 🔥 h/l
  if (key == "h" or key == "l") and counts[key] >= 20 then
    total_errors = total_errors + 1

    warn_hl()
    vim.cmd("sleep 700m")

    counts[key] = 0
  end
end, vim.api.nvim_create_namespace("hardcore_vim"))

-- 🚫 bloqueio de setas
local function block_arrow(key, msg)
  vim.keymap.set({ "n", "i" }, key, function()
    total_errors = total_errors + 1
    vim.notify("🤠 " .. msg, vim.log.levels.WARN)
    vim.cmd("sleep 600m")
  end)
end

block_arrow("<Up>", "Usa k 😅")
block_arrow("<Down>", "Usa j 😏")
block_arrow("<Left>", "Usa h 👈")
block_arrow("<Right>", "Usa l 👉")

-- 📊 relatório ao sair
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    local duration = math.floor((vim.loop.now() - session_start) / 1000)

    vim.notify("📊 Sessão Vim:\n⏱ Tempo: " .. duration .. "s\n❌ Excessos: " .. total_errors, vim.log.levels.INFO)
  end,
})

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.keymap.set("n", "<leader>pf", function()
  require("utils.fstring").transform()
end, { desc = "Transformar em f-string" })

print("hardcore carregado!")

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pf", "<cmd>lua require('utils.fstring').transform()<CR>", {
  desc = "Transformar em f-string",
  noremap = true,
  silent = true,
})

-- sair do teminal com
vim.keymap.set("t", "jk", [[<C-\><C-n>]], {
  noremap = true,
  silent = true,
  desc = "Sair do terminal",
})

vim.keymap.set("n", "<leader>ti", "i", {
  desc = "Voltar pro terminal insert",
})

vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]])
vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]])
vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]])
vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]])

return M
