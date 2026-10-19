return {
  {
    "stevearc/oil.nvim",
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    opts = {},
    keys = {
      {
        "-",
        function()
          require("oil").toggle_float()
        end,
        desc = "Oil toggle float",
      },
    },
  },
}
