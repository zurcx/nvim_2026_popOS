return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = 15,
      open_mapping = [[<c-\>]], -- mantém o seu
      direction = "horizontal",
      start_in_insert = true,
      persist_size = true,
      shade_terminals = true,
      persist_mode = true, -- 🔥 mantém modo (top)
      close_on_exit = false,
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

      -- 🚀 abrir terminal geral
      vim.keymap.set("n", "<leader>tt", function()
        term:toggle()
      end, { desc = "Terminal" })

      -- 🚀 dev server
      vim.keymap.set("n", "<leader>tn", function()
        dev:toggle()
      end, { desc = "Dev server" })

      -- 🔥 sair do terminal (ESC e jk)
      vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
      vim.keymap.set("t", "jk", [[<C-\><C-n>]], { noremap = true, silent = true })

      -- 🔥 navegar entre janelas direto do terminal
      vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]])
      vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]])
      vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]])
      vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]])

      vim.keymap.set("n", "<leader>rp", function()
        vim.cmd("w")
        local file = vim.fn.expand("%:p")
        vim.cmd("TermExec cmd='clear && python3 " .. file .. "'")
      end, { desc = "Run Python" })

      -- 🚀 rodar Node
      vim.keymap.set("n", "<leader>rn", function()
        vim.cmd("w")
        term:toggle()
        term:send("clear && node " .. vim.fn.expand("%"), true)
      end, { desc = "Run Node" })

      -- 🚀 rodar arquivo executável
      vim.keymap.set("n", "<leader>rr", function()
        vim.cmd("w")
        term:toggle()
        term:send("clear && ./" .. vim.fn.expand("%"), true)
      end, { desc = "Run file" })
    end,
  },
}
