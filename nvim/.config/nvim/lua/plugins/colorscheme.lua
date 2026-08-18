return {
  -- add sonokai
  {
    "sainnhe/sonokai",
    init = function()
      vim.g.sonokai_transparent_background = 1
      vim.g.sonokai_float_style = "blend"
    end,
  },

  -- Configure LazyVim to load sonokai
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "sonokai",
    },
  },
}
