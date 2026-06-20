return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",

    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },

    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        popup_border_style = "rounded",

        enable_git_status = true,
        enable_diagnostics = true,

        filesystem = {
          filtered_items = {
            visible = true, -- 🔥 mostra arquivos ocultos
            hide_dotfiles = false,
            hide_gitignored = false,
          },

          follow_current_file = {
            enabled = true, -- 🔥 acompanha arquivo atual
          },

          use_libuv_file_watcher = true, -- 🔥 auto refresh
        },

        window = {
          width = 30,
          mappings = {
            ["l"] = "open",
            ["h"] = "close_node",
            ["<CR>"] = "open",
            ["o"] = "open",
            ["P"] = { "toggle_preview", config = { use_float = true } }, -- 🔥 preview
          },
        },
      })

      -- 🚀 atalhos
      vim.keymap.set("n", "<leader>fe", "<cmd>Neotree toggle<CR>", {
        desc = "Explorer",
      })

      vim.keymap.set("n", "<leader>ff", "<cmd>Neotree focus<CR>", {
        desc = "Explorer focus",
      })
    end,
  },
}
