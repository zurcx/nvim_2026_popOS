return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      "zbirenbaum/copilot.lua",
      "nvim-lua/plenary.nvim",
    },
    opts = {},
    keys = {
      {
        "<leader>cc",
        function()
          require("CopilotChat").toggle()
        end,
        desc = "Copilot Chat",
      },
    },
  },
}
