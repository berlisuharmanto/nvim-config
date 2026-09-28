-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Neo-tree keymaps
vim.keymap.set("n", "<leader>b", "<cmd>Neotree filesystem reveal left<CR>", { desc = "Neo-tree reveal left" })
vim.keymap.set("n", "<leader>n", "<cmd>Neotree filesystem close<CR>", { desc = "Neo-tree close" })

-- Telescope keymaps
vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<CR>", { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", function()
  local ok, ext = pcall(function()
    return require("telescope").extensions.live_grep_args.live_grep_args
  end)
  if ok and ext then
    ext()
  else
    require("telescope.builtin").live_grep()
  end
end, { desc = "Telescope live grep args" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Telescope help tags" })

-- Oil keymap
vim.keymap.set("n", "-", function()
  require("oil").toggle_float()
end, { desc = "Oil toggle float" })
