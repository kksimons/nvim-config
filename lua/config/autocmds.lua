-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Disable completion in neo-tree to prevent interference with delete confirmation
vim.api.nvim_create_autocmd("FileType", {
  pattern = "neo-tree",
  callback = function()
    vim.opt_local.complete = ""
    vim.opt_local.completeopt = ""
    -- Disable cmp if available
    if package.loaded["cmp"] then
      require("cmp").setup.buffer({ enabled = false })
    end
      -- Disable blink.cmp if available
      if package.loaded["blink.cmp"] then
        require("blink.cmp").setup.buffer({ enabled = false })
      end
  end,
})

-- Also disable completion when entering neo-tree windows
vim.api.nvim_create_autocmd("WinEnter", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "neo-tree" then
      vim.opt_local.complete = ""
      vim.opt_local.completeopt = ""
      if package.loaded["cmp"] then
        require("cmp").setup.buffer({ enabled = false })
      end
      -- Disable blink.cmp if available
      if package.loaded["blink.cmp"] then
        require("blink.cmp").setup.buffer({ enabled = false })
      end
    end
  end,
})

-- Disable completion when confirmation prompts appear
vim.api.nvim_create_autocmd("CmdlineEnter", {
  callback = function()
    local cmdline = vim.fn.getcmdline()
    if cmdline:match("Delete") or cmdline:match("delete") or cmdline:match("y/n") then
      vim.opt_global.complete = ""
      vim.opt_global.completeopt = ""
      if package.loaded["cmp"] then
        require("cmp").setup.buffer({ enabled = false })
      end
      -- Disable blink.cmp if available
      if package.loaded["blink.cmp"] then
        require("blink.cmp").setup.buffer({ enabled = false })
      end
    end
  end,
})
