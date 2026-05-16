return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = 15, -- altura do terminal (pode ajustar)
      open_mapping = [[<c-\>]],
      direction = "horizontal", -- 🔥 fica embaixo
      start_in_insert = true,
      persist_size = true,
      shade_terminals = true,
    },

    config = function(_, opts)
      require("toggleterm").setup(opts)

      local Terminal = require("toggleterm.terminal").Terminal

      -- 🔥 terminal fixo pra dev server
      local dev = Terminal:new({
        cmd = "npm run dev",
        direction = "horizontal",
        hidden = true,
      })

      -- 🔥 terminal geral
      local term = Terminal:new({
        direction = "horizontal",
        hidden = true,
      })

      -- 🚀 atalhos
      vim.keymap.set("n", "<leader>tt", function()
        term:toggle()
      end, { desc = "Terminal" })

      vim.keymap.set("n", "<leader>tn", function()
        dev:toggle()
      end, { desc = "Dev server" })

      -- 🔥 sair do terminal fácil
      vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })
    end,
  },
}
