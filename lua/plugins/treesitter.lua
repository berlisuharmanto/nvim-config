return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "EmranMR/tree-sitter-blade",
    "nvim-treesitter/nvim-treesitter-context"
  },
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = { enable = true },
    })
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.blade = {
      auto_install = true,
      install_info = {
        url = "https://github.com/EmranMR/tree-sitter-blade",
        files = { "src/parser.c" },
        branch = "main",
      },
      filetype = "blade",
    }
    local context = require("treesitter-context")
    context.setup({
    })
    vim.filetype.add({
      pattern = {
        [".*%.blade%.php"] = "blade",
      },
    })
  end,
}
