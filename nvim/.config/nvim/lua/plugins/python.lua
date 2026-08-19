-- `ruff check` diagnostics, same command CI runs. The binary comes from PATH, so
-- a project's .envrc picks its pinned copy over the global one.
return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        python = { "ruff" },
      },
    },
  },
}
