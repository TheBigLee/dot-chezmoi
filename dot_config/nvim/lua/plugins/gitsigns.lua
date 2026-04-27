return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    current_line_blame = true,
    on_attach = function(buf)
      local gs = package.loaded.gitsigns
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
      end
      map("n", "]c", function() gs.nav_hunk("next") end, "Next hunk")
      map("n", "[c", function() gs.nav_hunk("prev") end, "Prev hunk")
      map("n", "<leader>gs", gs.stage_hunk,         "Stage hunk")
      map("n", "<leader>gr", gs.reset_hunk,         "Reset hunk")
      map("v", "<leader>gs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage hunk")
      map("v", "<leader>gr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Reset hunk")
      map("n", "<leader>gS", gs.stage_buffer,       "Stage buffer")
      map("n", "<leader>gR", gs.reset_buffer,       "Reset buffer")
      map("n", "<leader>gp", gs.preview_hunk,       "Preview hunk")
      map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame line")
      map("n", "<leader>gd", gs.diffthis,           "Diff this")
      map("n", "<leader>gB", gs.toggle_current_line_blame, "Toggle line blame")
    end,
  },
}
