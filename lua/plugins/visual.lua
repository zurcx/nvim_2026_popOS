return {
  {
    dir = "/home/luiz.cruz/.local/share/nvim/lazy/smear-cursor.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("smear_cursor").setup({})
    end,
  },
}
