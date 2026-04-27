local parsers = {
  "bash", "diff", "dockerfile",
  "git_config", "git_rebase", "gitcommit", "gitignore",
  "go", "gomod", "gosum", "gowork",
  "hyprlang", "jq", "json", "jsonnet",
  "lua", "luadoc", "luap",
  "make", "markdown", "markdown_inline",
  "nix", "python", "regex", "ssh_config",
  "toml", "vim", "vimdoc", "yaml",
}

local filetypes = {
  "sh", "bash", "diff", "dockerfile",
  "gitconfig", "gitrebase", "gitcommit", "gitignore",
  "go", "gomod", "gosum", "gowork",
  "hyprlang", "jq", "json", "jsonnet",
  "lua",
  "make", "markdown",
  "nix", "python", "ssh_config",
  "toml", "vim", "help", "yaml",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      require("nvim-treesitter").install(parsers)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = filetypes,
        callback = function(args)
          local buf = args.buf
          local max = 100 * 1024
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max then return end
          pcall(vim.treesitter.start, buf)
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      max_lines = 3,
      mode = "cursor",
    },
  },
}
