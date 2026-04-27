return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      lua       = { "stylua" },
      go        = { "goimports", "gofumpt" },
      json      = { "jq" },
      jsonnet   = { "jsonnetfmt" },
      yaml      = { "yamlfmt" },
      sh        = { "shfmt" },
      bash      = { "shfmt" },
      markdown  = { "prettier" },
    },
    format_on_save = function(bufnr)
      if vim.b[bufnr].disable_autoformat or vim.g.disable_autoformat then
        return
      end
      return { timeout_ms = 1500, lsp_format = "fallback" }
    end,
  },
  init = function()
    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then vim.b.disable_autoformat = true
      else vim.g.disable_autoformat = true end
    end, { bang = true, desc = "Disable autoformat (! = buffer)" })
    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, { desc = "Enable autoformat" })
  end,
}
