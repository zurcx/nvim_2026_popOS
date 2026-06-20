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

-- Configurações do vim-dadbod-ui
vim.g.db_ui_save_location = vim.fn.stdpath("config") .. "/db_ui"
vim.g.db_ui_show_database_navigation = 1

-- Função para ler o arquivo .env manualmente antes de carregar o Dadbod
local function load_env()
  local env_file = vim.fn.getcwd() .. "/.env"
  if vim.fn.filereadable(env_file) == 1 then
    for line in io.lines(env_file) do
      if not line:match("^%s*#") and line:match("=") then
        local key, value = line:match("^([^=]+)=(.*)$")
        if key and value then
          -- Limpa espaços em branco das pontas da chave e do valor
          key = key:match("^%s*(.-)%s*$")
          value = value:match("^%s*(.-)%s*$")
          -- Remove aspas se houver
          value = value:gsub("^['\"]", ""):gsub("['\"]$", "")

          -- Injeta em ambos os escopos para garantir a leitura do plugin
          vim.env[key] = value
          string.gsub(key, ".*", function(k)
            vim.fn.setenv(k, value)
          end)
        end
      end
    end
  end
end

-- Executa a leitura do .env na pasta atual
load_env()

-- Agora o vim.g.dbs puxa com total certeza usando a função de fallback do sistema
vim.g.dbs = {
  vendas_mysql = vim.env.DB_MYSQL or os.getenv("DB_MYSQL"),
  locadora_oracle = vim.env.DB_ORACLE_TESTE or os.getenv("DB_ORACLE_TESTE"),
}

-- Desativa o format-on-save apenas para arquivos SQL para não quebrar queries
vim.api.nvim_create_autocmd("FileType", {
  pattern = "sql",
  callback = function()
    vim.b.autoformat = false
  end,
})
