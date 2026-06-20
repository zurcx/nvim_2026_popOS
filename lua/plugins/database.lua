return {
  {
    "tpope/vim-dadbod",
  },

  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      "tpope/vim-dadbod",
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },

  {
    "kristijanhusak/vim-dadbod-completion",
    ft = { "sql" },
    dependencies = {
      "hrsh7th/nvim-cmp",
      "kristijanhusak/vim-dadbod",
    },
  },
}
