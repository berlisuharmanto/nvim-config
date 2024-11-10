return {
  "nvimtools/none-ls-extras.nvim",
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup {
      sources = {
          require("none-ls.diagnostics.cpplint"),
          require("none-ls.formatting.jq"),
          require("none-ls.code_actions.eslint"),
        }
      }
  end
}
