return {
  {
    "stevearc/conform.nvim",

    opts = {
      -- 🔥 FORMATADORES POR LINGUAGEM
      formatters_by_ft = {

        -- 🐍 PYTHON (rápido e moderno)
        python = { "ruff_fix", "ruff_format" },

        -- 🌐 WEB (mantém seu setup atual)
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },

        -- 🐚 (opcional)
        sh = { "shfmt" },
      },

      -- ⚡ FORMATAR AO SALVAR
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
}
