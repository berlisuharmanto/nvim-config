return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.completion.spell,
        null_ls.builtins.formatting.blade_formatter.with({
          filetypes = {
            "blade",
          },
        }),
        null_ls.builtins.formatting.prettier.with({
          filetypes = {
            "html",
            "css",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "json",
            "jsonc",
            "yaml",
            "markdown",
            "markdown.mdx",
            "graphql",
            "handlebars",
            "python",
            "less",
            "sass",
            "scss",
            "pug",
            "lua",
          },
        }),
        -- null_ls.builtins.formatting.phpcsfixer,
        null_ls.builtins.formatting.clang_format,
        require("none-ls.diagnostics.eslint_d"),
      },
    })
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    vim.lsp.buf.format({ timeout_ms = 5000 })
  end,
}
