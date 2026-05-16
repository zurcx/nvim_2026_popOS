return {
  { "tpope/vim-dadbod" },

  {
    "kristijanhusak/vim-dadbod-ui",
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection" },
    dependencies = { "tpope/vim-dadbod" },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },

  {
    "kristijanhusak/vim-dadbod-completion",
    ft = { "sql", "mysql", "plsql" },
    dependencies = { "hrsh7th/nvim-cmp" },
  },
}
