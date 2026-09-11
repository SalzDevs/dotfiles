vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.undofile = true
vim.opt.hidden = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"  
vim.opt.mouse = "a"

vim.g.mapleader = " "

vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
vim.keymap.set({ "n", "v" }, "<D-c>", '"+y', { desc = "Copy to clipboard" })
vim.keymap.set({ "n", "v" }, "<D-v>", '"+p', { desc = "Paste from clipboard" })
vim.keymap.set("i", "<D-v>", '<C-r>+', { desc = "Paste from clipboard" })

vim.opt.clipboard = "unnamedplus"
vim.opt.timeoutlen = 300

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          layout_config = {
            height = 0.6,
            width = 0.8,
          },
        },
      })
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
    end,
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd", "zls", "rust_analyzer", "pyright", "gopls", "ts_ls", "ols" },
        automatic_installation = true,
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({ capabilities = capabilities })
          end,
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- No LSP keymaps - only inline diagnostics (virtual text + signs)
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = ">>",
            [vim.diagnostic.severity.WARN] = ">>",
            [vim.diagnostic.severity.HINT] = ">>",
            [vim.diagnostic.severity.INFO] = ">>",
          },
        },
        virtual_text = true,
        update_in_insert = false,
      })
    end,
  },
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = {
      "L3MON4D3/LuaSnip",
    },
    opts = {
      -- Manual accept: menu shows but nothing is inserted until YOU confirm
      -- with Cmd-Enter / Ctrl-Y, Enter for newline, or mouse click.
      keymap = {
        preset = "default",
        ["<CR>"] = { "fallback" },
        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
        ["<D-y>"] = { "select_and_accept", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
        ["<C-n>"] = { "select_next", "fallback_to_mappings" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      },
      completion = {
        list = {
          selection = { preselect = false, auto_insert = false },
        },
        menu = { auto_show = true },
        ghost_text = { enabled = false },
        trigger = { show_on_keyword = true, show_on_trigger_character = true },
      },
      snippets = { preset = "luasnip" },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = 15,
      direction = "horizontal",
      shade_terminals = true,
    },
    config = function()
      require("toggleterm").setup({
        size = 15,
        direction = "horizontal",
        shade_terminals = true,
      })
      vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<CR>", { desc = "Toggle Terminal" })
    end,
  },
})

vim.opt.guicursor = "a:block"

