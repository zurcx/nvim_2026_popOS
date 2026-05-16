return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      labels = "asdfghjklqwertyuiopzxcvbnm",

      search = {
        multi_window = true,
        forward = true,
        wrap = true,
      },

      jump = {
        autojump = true,
      },

      modes = {
        search = {
          enabled = false, -- 🔥 ESSENCIAL (corrige n/N)
        },
      },
    },

    keys = {
      -- 🚀 TELEPORTE PRINCIPAL
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash Jump",
      },

      -- 🔥 USA OUTRA TECLA (NÃO /)
      {
        "<leader>s",
        mode = "n",
        function()
          require("flash").jump({
            pattern = vim.fn.input("Flash: "),
          })
        end,
        desc = "Flash Search",
      },

      -- 🌳 navegação estrutural
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
    },
  },
}
