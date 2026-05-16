local M = {}

function M.transform()
  -- pega linha atual
  local line = vim.api.nvim_get_current_line()

  -- verifica se tem marcador
  if not line:find("%*") then
    vim.notify("Nenhum '*' encontrado na linha", vim.log.levels.WARN)
    return
  end

  -- pede variáveis
  local input = vim.fn.input("Vars (a,b,c): ")
  local vars = vim.split(input, ",")

  local i = 1

  -- substitui * por {var}
  local new_line = line:gsub("%*", function()
    local v = vim.trim(vars[i] or "var")
    i = i + 1
    return "{" .. v .. "}"
  end)

  -- adiciona print(f"...")
  new_line = 'print(f"' .. new_line .. '")'

  -- substitui linha
  vim.api.nvim_set_current_line(new_line)
end

return M
