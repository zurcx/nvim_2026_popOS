return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",

    config = function()
      local wk = require("which-key")

      wk.setup({
        delay = 100,
      })

      wk.register({
        ["<leader>e"] = { name = "🚀 Execute" },
        ["<leader>t"] = { name = "🖥️ Terminal" },
        ["<leader>f"] = { name = "🔍 Find" },
        ["<leader>c"] = { name = "🧠 Code" },
        ["<leader>x"] = { name = "🧹 Utils" },
      })

      wk.register({
        e = {
          name = "🚀 Execute",
          e = "Run arquivo",
          p = "Python run",
        },

        t = {
          name = "🖥️ Terminal",
          t = "Toggle terminal",
          n = "Dev server",
        },

        f = {
          name = "🔍 Find",
          f = "Find files",
          g = "Grep",
        },

        c = {
          name = "🧠 Code",
          f = "F-string",
        },

        x = {
          name = "🧹 Utils",
          x = "Clear highlight",
        },
      }, { prefix = "<leader>" })
    end,
  },
}
