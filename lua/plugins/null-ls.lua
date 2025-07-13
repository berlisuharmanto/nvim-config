return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.completion.spell,
        null_ls.builtins.formatting.prettier.with({
          filetypes = {
            "html",
            "css",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
            "json",
            "jsonc",
            "yaml",
            "markdown",
            "markdown.mdx",
            "graphql",
            "handlebars",
            "php",
            "blade",
            "less",
            "sass",
            "scss",
            "pug",
            "lua",
          },
        }),
        -- null_ls.builtins.formatting.phpcsfixer,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.blade_formatter,
        require("none-ls.diagnostics.eslint_d")
      },
    })
    vim.g.lazyvim_prettier_needs_config = false
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
