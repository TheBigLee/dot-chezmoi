return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    vim.diagnostic.config({
      virtual_text = { spacing = 4, prefix = "●" },
      severity_sort = true,
      float = { border = "rounded", source = "if_many" },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "",
          [vim.diagnostic.severity.WARN]  = "",
          [vim.diagnostic.severity.HINT]  = "",
          [vim.diagnostic.severity.INFO]  = "",
        },
      },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local buf = args.buf
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
        end
        map("n", "gd", vim.lsp.buf.definition,      "Goto Definition")
        map("n", "gr", vim.lsp.buf.references,      "References")
        map("n", "gD", vim.lsp.buf.declaration,     "Declaration")
        map("n", "gI", vim.lsp.buf.implementation,  "Implementation")
        map("n", "gT", vim.lsp.buf.type_definition, "Type Definition")
        map("n", "K",  vim.lsp.buf.hover,           "Hover")
        map("n", "<leader>cr", vim.lsp.buf.rename,        "Rename")
        map("n", "<leader>ca", vim.lsp.buf.code_action,   "Code Action")
        map("n", "<leader>cd", vim.diagnostic.open_float, "Line Diagnostics")
        map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end,  "Next Diagnostic")
        map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, "Prev Diagnostic")
      end,
    })

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = { globals = { "vim", "Snacks" } },
          completion = { callSnippet = "Replace" },
          telemetry = { enabled = false },
        },
      },
    })

    vim.lsp.config("gopls", {
      settings = {
        gopls = {
          usePlaceholders = true,
          completeUnimported = true,
          staticcheck = true,
          analyses = {
            unusedparams = true,
            unusedvariable = true,
            shadow = true,
            nilness = true,
            unusedwrite = true,
            useany = true,
          },
          hints = {
            parameterNames = true,
            assignVariableTypes = true,
            constantValues = true,
          },
        },
      },
    })

    vim.lsp.config("jsonnet_ls", {
      settings = { formatting = { PadArrays = true } },
    })

    vim.lsp.enable({ "lua_ls", "gopls", "jsonls", "jsonnet_ls", "yamlls", "bashls", "marksman" })
  end,
}
