return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<C-l>",
          next = "<C-j>",
          prev = "<C-k>",
        },
      },
      panel = { enabled = false },
    },
  },
}
