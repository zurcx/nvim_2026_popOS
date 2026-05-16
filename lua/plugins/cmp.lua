return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
    },

    opts = function(_, opts)
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- 🔥 CARREGA SNIPPETS
      require("luasnip.loaders.from_vscode").lazy_load({
        include = { "html", "javascript", "typescriptreact", "python" },
      })

      require("luasnip.loaders.from_lua").load({
        paths = "~/.config/nvim/lua/snippets",
      })

      -- 🔥 SNIPPET ENGINE
      opts.snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      }

      -- 🚀 MAPPINGS COMPLETOS
      opts.mapping = cmp.mapping.preset.insert({

        -- 🔥 TAB = SNIPPET FIRST
        ["<Tab>"] = cmp.mapping(function(fallback)
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          elseif cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s" }),

        -- 🚀 NAVEGAÇÃO AUTOCOMPLETE
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),

        -- 🔥 ABRIR MENU MANUAL
        ["<C-Space>"] = cmp.mapping.complete(),

        -- 🔥 FECHAR MENU
        ["<C-e>"] = cmp.mapping.abort(),

        -- 🔥 CONFIRMAR
        ["<CR>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = false,
            })
          else
            fallback()
          end
        end, { "i", "s" }),
      })

      -- 🔥 FONTES
      opts.sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      })

      return opts
    end,
  },
}
