return {
  "saghen/blink.cmp",
  version = "*",
  event = "InsertEnter",
  opts = {
    keymap = {
      preset = "default",
      ["<C-j>"]   = { "select_next", "fallback" },
      ["<C-k>"]   = { "select_prev", "fallback" },
      ["<Tab>"]   = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<CR>"]    = { "accept", "fallback" },
      ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"]   = { "hide", "fallback" },
      ["<C-u>"]   = { "scroll_documentation_up", "fallback" },
      ["<C-d>"]   = { "scroll_documentation_down", "fallback" },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
      menu = { border = "rounded" },
    },
    signature = { enabled = true, window = { border = "rounded" } },
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
}
