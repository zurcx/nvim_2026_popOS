return {
  {
    "mfussenegger/nvim-dap",
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dap-vscode-js").setup({
        debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
      })
    end,
  },
}
