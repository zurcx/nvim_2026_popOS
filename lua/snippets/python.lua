local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

-- 🔥 pega variável sob cursor
local function get_var()
  return vim.fn.expand("<cword>")
end

return {

  -- 🔥 PRINT RÁPIDO
  s("pr", {
    t("print("),
    i(1),
    t(")"),
  }),

  -- 🔥 PRINT FLEXÍVEL (SEM AUTO)
  s("prf", {
    t('print(f"'),
    i(1, "var"),
    t(": {"),
    i(2),
    t('}")'),
  }),

  -- ⚡ PRINT AUTOMÁTICO
  s("prfa", {
    t('print(f"'),
    i(1, "var"),
    t(": {"),
    f(function(args)
      return args[1][1]
    end, { 1 }),
    t('}")'),
  }),

  -- 🚀 AUTO DETECTA VAR SOB CURSOR
  s("prc", {
    t('print(f"'),
    f(function()
      return get_var()
    end),
    t(": {"),
    f(function()
      return get_var()
    end),
    t('}")'),
  }),

  -- 🔥 FUNÇÃO COMPLETA
  s("def", {
    t("def "),
    i(1, "nome"),
    t("("),
    i(2),
    t(") -> "),
    i(3, "None"),
    t({ ":", "    " }),
    i(0),
  }),

  -- 🔥 IF
  s("if", {
    t("if "),
    i(1, "condicao"),
    t({ ":", "    " }),
    i(0),
  }),

  -- 🔥 IF ELSE
  s("ife", {
    t("if "),
    i(1, "condicao"),
    t({ ":", "    " }),
    i(2),
    t({ "", "else:", "    " }),
    i(0),
  }),

  -- 🔥 FOR LOOP
  s("for", {
    t("for "),
    i(1, "item"),
    t(" in "),
    i(2, "iteravel"),
    t({ ":", "    " }),
    i(0),
  }),

  -- 🔥 RANGE LOOP
  s("fori", {
    t("for i in range("),
    i(1, "n"),
    t({ "):", "    " }),
    i(0),
  }),

  -- 🔥 WHILE
  s("wh", {
    t("while "),
    i(1, "condicao"),
    t({ ":", "    " }),
    i(0),
  }),

  -- 🔥 TRY / EXCEPT
  s("try", {
    t({ "try:", "    " }),
    i(1),
    t({ "", "except Exception as e:", "    print(e)" }),
  }),

  -- 🔥 LIST COMPREHENSION
  s("lc", {
    t("["),
    i(1, "x"),
    t(" for "),
    i(2, "x"),
    t(" in "),
    i(3, "iteravel"),
    t("]"),
  }),

  -- 🔥 MAIN
  s("main", {
    t({
      'if __name__ == "__main__":',
      "    ",
    }),
    i(0),
  }),

  -- 🔥 CLASS
  s("class", {
    t("class "),
    i(1, "Nome"),
    t(":"),
    t({ "", "    def __init__(self, " }),
    i(2),
    t({ "):", "        " }),
    i(0),
  }),

  -- 🔥 FAST DEBUG PRINT (com seleção)
  s("pp", {
    t('print(f"'),
    f(function(_, snip)
      return snip.env.TM_SELECTED_TEXT[1] or "var"
    end),
    t(": {"),
    i(1, "var"),
    t('}")'),
  }),

  -- 🔥 MULTI VAR DINÂMICO
  s("ppx", {
    f(function()
      local input = vim.fn.input("Vars: ")
      local vars = vim.split(input, ",")
      local parts = {}

      for _, v in ipairs(vars) do
        v = vim.trim(v)
        if v ~= "" then
          table.insert(parts, v .. ": {" .. v .. "}")
        end
      end

      return 'print(f"' .. table.concat(parts, ", ") .. '")'
    end),
  }),
}
