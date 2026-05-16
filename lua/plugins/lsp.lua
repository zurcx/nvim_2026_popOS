return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {

        -- 🔥 TYPESCRIPT (mantém o seu)
        tsserver = {
          filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
          },
        },

        -- 🔥 HTML
        html = {
          filetypes = {
            "html",
            "javascriptreact",
            "typescriptreact",
          },
        },

        -- 🔥 TAILWIND
        tailwindcss = {
          filetypes = {
            "html",
            "css",
            "javascriptreact",
            "typescriptreact",
          },
        },

        -- 🔥 EMMET (limitado pra não quebrar TSX)
        emmet_ls = {
          cmd = { "emmet-ls", "--stdio" },
          filetypes = {
            "html",
            "css",
          },
        },

        -- 🐍 PYTHON (PRO)
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                autoImportCompletions = true,
              },
            },
          },
        },
      },
    },
  },
}
