return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    opts = function(_, opts)
      local telescope = require("telescope")
      pcall(telescope.load_extension, "live_grep_args")
      pcall(telescope.load_extension, "file_browser")
    end,
    keys = {
      { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Telescope find files" },
      {
        "<leader>fg",
        function()
          local ok, ext = pcall(function()
            return require("telescope").extensions.live_grep_args.live_grep_args
          end)
          if ok and ext then
            ext()
          else
            require("telescope.builtin").live_grep()
          end
        end,
        desc = "Telescope live grep args",
      },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Telescope buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Telescope help tags" },
    },
  },
}
