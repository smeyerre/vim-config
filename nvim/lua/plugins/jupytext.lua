return {
  {
    'GCBallesteros/jupytext.nvim',
    ft = { 'ipynb', 'markdown' },  -- only load for notebooks
    opts = {
      style = "markdown",
      output_extension = "md",
      force_ft = "markdown"
    }
  }
}
