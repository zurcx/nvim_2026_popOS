return {
  {
    "numToStr/Comment.nvim",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      require("Comment").setup({
        padding = true,
        sticky = true,

        toggler = {
          line = "gcc", -- linha
          block = "gbc", -- bloco
        },

        opleader = {
          line = "gc",
          block = "gb",
        },

        mappings = {
          basic = true,
          extra = true,
        },

        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },
}
