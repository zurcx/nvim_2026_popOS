return {
  {
    "robitx/gp.nvim",
    config = function()
      require("gp").setup({
        providers = {
          ollama = {
            endpoint = "http://localhost:11434/v1/chat/completions",
          },
        },

        agents = {
          {
            name = "Ollama",
            provider = "ollama",
            model = "llama3",
          },
        },
      })

      -- 🔥 CHAT
      vim.keymap.set("n", "<leader>ai", ":GpChatNew<CR>", { desc = "IA Chat" })

      -- 🔥 EXPLICAR
      vim.keymap.set("v", "<leader>ae", ":GpChatPaste explain this code<CR>")

      -- 🔥 REFATORAR
      vim.keymap.set("v", "<leader>ar", ":GpChatPaste refactor this code<CR>")

      -- 🔥 GERAR FUNÇÃO
      vim.keymap.set("n", "<leader>af", ":GpChatNew<CR>iCreate a python function to ")
    end,
  },
}
