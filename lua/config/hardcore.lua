local M = {}

-- 🔥 leader precisa vir antes de tudo
vim.g.mapleader = " "

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

-- 🚀 HARDCORE NAV
vim.on_key(function(char)
  local key = vim.fn.keytrans(char)
  local now = vim.loop.now()

  if vim.api.nvim_get_mode().mode ~= "n" then
    return
  end

  if now - last_time > 2000 then
    counts = { j = 0, k = 0, h = 0, l = 0 }
  end

  last_time = now

  if not counts[key] then
    return
  end

  counts[key] = counts[key] + 1

  if (key == "j" or key == "k") and counts[key] >= 15 then
    total_errors = total_errors + 1
    warn_jk()
    vim.cmd("sleep 800m")
    counts[key] = 0
  end

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

-- 🔍 SEARCH MELHORADO
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- ========================
-- 🚀 EXECUÇÃO
-- ========================

-- Python direto
vim.keymap.set("n", "<leader>pp", function()
  vim.cmd("w")
  local file = vim.fn.expand("%:p")
  vim.cmd("TermExec cmd='clear && python3 \"" .. file .. "\"'")
end, { desc = "Python Run" })

-- Runner universal
vim.keymap.set("n", "<leader>e", function()
  vim.cmd("w")
  local file = vim.fn.expand("%")
  local ext = vim.fn.expand("%:e")

  if ext == "py" then
    vim.cmd("TermExec cmd='clear && python3 " .. file .. "'")
  elseif ext == "js" then
    vim.cmd("TermExec cmd='clear && node " .. file .. "'")
  elseif ext == "sh" then
    vim.cmd("TermExec cmd='clear && bash " .. file .. "'")
  else
    print("Tipo não suportado")
  end
end, { desc = "Run Auto" })

-- ========================
-- 🧠 CÓDIGO
-- ========================

vim.keymap.set("n", "<leader>cf", function()
  require("utils.fstring").transform()
end, { desc = "F-string" })

-- ========================
-- 🖥️ TERMINAL
-- ========================

-- sair do terminal
vim.keymap.set("t", "jk", [[<C-\><C-n>]], {
  noremap = true,
  silent = true,
  desc = "Terminal Normal Mode",
})

-- voltar pro insert (opcional)
vim.keymap.set("n", "<leader>ti", "i", {
  desc = "Terminal Insert",
})

-- navegação entre janelas no terminal
vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]])
vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]])
vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]])
vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]])

-- ========================
-- 🧹 UTIL
-- ========================

vim.keymap.set("n", "<leader>x", "<cmd>nohlsearch<CR>", {
  desc = "Clear Highlight",
})

vim.keymap.set("n", "<leader>db", "<cmd>DBUIToggle<CR>", {
  desc = "Database Explorer",
})

vim.keymap.set("n", "<leader>dq", "<cmd>DBUIFindBuffer<CR>", {
  desc = "Query Buffer",
})

-- ========================
-- 󰆼 BANCOS DE DADOS (CONFIG)
-- ========================

-- Garante que a tabela global g.dbs exista (para herdar as conexões do .env)
vim.g.dbs = vim.g.dbs or {}

-- Tabela local com as suas conexões estáticas de estudo
local conexoes_fixas = {
  postgres = "postgres://luiz.cruz:Zurcz@localhost:5432/pizzaria",
  mysql_loja_aula = "mysql://luiz.cruz:Cruz1974@localhost:3306/loja_aula",
  mysql_meu_ecommerce = "mysql://luiz.cruz:Cruz1974@localhost:3306/meu_ecommerce",
  mysql_livraria_estudo = "mysql://luiz.cruz:Cruz1974@localhost:3306/livraria_estudo",
  mysql_livraria_biblioteca = "mysql://luiz.cruz:Cruz1974@localhost:3306/biblioteca",
  mysql_loja_virtual = "mysql://luiz.cruz:Cruz1974@localhost:3306/loja_virtual",
  mysql_streaming = "mysql://luiz.cruz:Cruz1974@localhost:3306/streaming",
  mysql_mobilidade = "mysql://luiz.cruz:Cruz1974@localhost:3306/mobilidade",
  mysql_financeiro = "mysql://luiz.cruz:Cruz1974@localhost:3306/financeiro",
}

-- Mescla as conexões fixas com as dinâmicas (sem apagar o Oracle/.env)
local dbs_atualizado = vim.g.dbs
for k, v in pairs(conexoes_fixas) do
  dbs_atualizado[k] = v
end

-- Devolve a tabela unificada para a variável global do Dadbod
vim.g.dbs = dbs_atualizado

-- Salvar query sincronizando a aba superior (Bufferline) e a lateral do Dadbod
vim.keymap.set("n", "<leader>bn", function()
  if vim.bo.filetype == "sql" or vim.bo.filetype == "mysql" then
    -- Pede o nome para o usuário
    local nome = vim.fn.input("Nome da Query (sem espacos): ")

    if nome ~= "" then
      -- 1. Remove espaços para evitar quebra de nomes
      nome = nome:gsub("%s+", "_")

      -- 2. Força a extensão .sql para a Bufferline manter o Highlighting
      local nome_com_extensao = nome
      if not nome_com_extensao:match("%.sql$") then
        nome_com_extensao = nome_com_extensao .. ".sql"
      end

      -- 3. Altera o nome do buffer na memória na hora (muda a aba de cima)
      vim.cmd("file " .. vim.fn.fnameescape(nome_com_extensao))

      -- 4. Dispara o salvamento oficial do Dadbod via API de teclas (muda a lateral)
      -- Isso vai abrir o prompt nativo do Dadbod pré-preenchido ou pronto para salvar
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Plug>(DBUI_SaveQuery)", true, true, true), "m", true)

      -- 5. Atualiza a interface visual
      vim.cmd("redrawtabline")
    end
  else
    vim.notify("Aviso: Use este comando apenas dentro de uma query SQL!", vim.log.levels.WARN)
  end
end, { desc = "Salvar e Sincronizar Nome da Query" })

-- Executar APENAS o bloco/query atual onde o cursor está posicionado
vim.keymap.set("v", "<leader>r", "<Plug>(DBUI_ExecuteQuery)", { desc = "Executar Seleção SQL" })
vim.keymap.set("n", "<leader>r", "vip<Plug>(DBUI_ExecuteQuery)", { desc = "Executar Query Atual" })

print("🔥 hardcore carregado")

return M
