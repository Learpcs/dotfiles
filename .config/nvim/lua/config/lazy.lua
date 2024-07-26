local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

vim.opt.expandtab = true
vim.opt.tabstop = 3
vim.opt.shiftwidth = 3
vim.opt.softtabstop = 3
vim.opt.rnu = true
vim.keymap.set("n", "<F9>", function() vim.cmd(":w | make | !./main") end)
vim.keymap.set("n", "<F1>", function() vim.cmd("!./main") end)

require("lazy").setup({
  spec = {
     { import = "plugins" },
  },
  install = { colorscheme = { "default" }},
  -- automatically check for plugin updates
  checker = { enabled = false },
})

vim.cmd("colorscheme tokyonight-night")

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "clangd", "pylsp", "cmake", "ltex"},
})

require('lspconfig').lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = {'vim'}
      }
    }
  }
})

require('lspconfig').clangd.setup {
  init_options = {
    fallbackFlags = {'--std=c++23', '-Wall', '-Wextra', '-Wpedantic', '-Wshadow', '-Wconversion'}
  },
}

require("lspconfig").pylsp.setup{}
require("lspconfig").cmake.setup{}
-- require("lspconfig").ltex.setup{}

local ls = require("luasnip")
require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/lua/snippets"})

vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-H>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})

vim.opt.langmap='ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯБЮЖЭХЪ;ABCDEFGHIJKLMNOPQRSTUVWXYZ<>:\"{},фисвуапршолдьтщзйкыегмцчняюж.эхъ;abcdefghijklmnopqrstuvwxyz./;\'[]'

