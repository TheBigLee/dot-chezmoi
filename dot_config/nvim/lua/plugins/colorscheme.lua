return {
  "rose-pine/neovim",
  name = "rose-pine",
  priority = 1000,
  config = function()
    require("rose-pine").setup({
      disable_background = true,
      disable_float_background = true,
      styles = { italic = false },
    })
    vim.cmd.colorscheme("rose-pine-moon")
  end,
}
