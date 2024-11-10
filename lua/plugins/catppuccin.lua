return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  integration = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
  },
  config = function ()
    vim.cmd.colorscheme "catppuccin"
  end
} 
