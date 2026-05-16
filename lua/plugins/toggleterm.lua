return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        -- 🔥 atalho principal
        open_mapping = [[<leader>tt]],

        -- 🔥 comportamento
        start_in_insert = true, -- já abre digitando
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        persist_mode = true,

        -- 🔥 layout
        direction = "horizontal",
        size = 15,

        -- 🔥 aparência
        shade_terminals = true,
        shading_factor = 2,

        -- 🔥 ao abrir
        on_open = function(term)
          vim.cmd("startinsert") -- garante modo insert
        end,

        -- 🔥 ao fechar
        on_close = function(term)
          vim.cmd("startinsert")
        end,
      })

      -- 🚀 atalhos extras

      -- abrir terminal flutuante
      vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Terminal Float" })

      -- abrir terminal vertical
      vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "Terminal Vertical" })

      -- sair do terminal (modo normal)
      vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Sair do terminal" })

      -- navegar entre janelas
      vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]])
      vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]])
      vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]])
      vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]])
    end,
  },
}
