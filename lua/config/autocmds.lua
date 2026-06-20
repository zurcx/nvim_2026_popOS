vim.api.nvim_create_autocmd("BufWritePre", {

  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },

  callback = function()
    vim.lsp.buf.code_action({

      apply = true,

      context = {

        only = { "source.organizeImports" },
      },
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {

  pattern = "sql",

  callback = function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)

      if vim.bo[buf].filetype == "snacks_dashboard" then
        vim.api.nvim_win_close(win, true)
      end
    end
  end,
})
