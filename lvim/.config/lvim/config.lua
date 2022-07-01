--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
-- lvim.opt.ttimeoutle
-- lvim.opt.timeoutlen = 1000
-- lvim.opt.ttimeoutlen = 0

-- vim.opt.guicursor = a:blinkon100

vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0
lvim.log.level = "warn"
lvim.format_on_save = true
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
-- 1

-- vim.keymap.del("n", "<C-a>")
-- vim.keymap.del("n", "<C-a>")
-- lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
vim.keymap.set("n", "<C-a>", "ggVG")
-- lvim.keys.normal_mode["<C-a>"] = "gg<S-v>G"

-- unmap a default keymapping
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

-- lvim.builtin.treesitter.highlight.enabled = false
lvim.builtin.treesitter.ignore_install = { "haskell" }
-- lvim.lsp.document_highlight = false
-- lvim.lsp.diagnostics.virtual_text = true

lvim.lsp.diagnostics.virtual_text = false



-- cmp
lvim.builtin.cmp.confirm_opts.select = true

lvim.builtin.nvimtree.setup.actions.open_file.quit_on_open = true


-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skiipped for the current filetype
-- vim.tbl_map(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
local h = require("null-ls.helpers")
local cmd_resolver = require("null-ls.helpers.command_resolver")
local u = require("null-ls.utils")
formatters.setup {
  -- { command = "prettier", filetypes = { "typescript" } },
  { command = "black", filetypes = { "python" } },
  { command = "isort", filetypes = { "python" } },
  {
    command = "prettier",
    args = h.range_formatting_args_factory({
      "--stdin-filepath",
      "$FILENAME",
    }, "--range-start", "--range-end", { row_offset = -1, col_offset = -1 }),
    to_stdin = true,
    dynamic_command = cmd_resolver.from_node_modules,
    cwd = h.cache.by_bufnr(function(params)
      return u.root_pattern(
      -- https://prettier.io/docs/en/configuration.html
        ".prettierrc",
        ".prettierrc.json",
        ".prettierrc.yml",
        ".prettierrc.yaml",
        ".prettierrc.json5",
        ".prettierrc.js",
        ".prettierrc.cjs",
        ".prettier.config.js",
        ".prettier.config.cjs",
        ".prettierrc.toml",
        "package.json"
      )(params.bufname)
    end),
  },
}

-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   {
--     command = "eslint_d",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "javascriptreact" },
--   },
-- }

-- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  -- { command = "flake8", filetypes = { "python" } },
  -- {
  --   -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
  --   command = "shellcheck",
  --   ---@usage arguments to pass to the formatter
  --   -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
  --   extra_args = { "--severity", "warning" },
  -- },
  -- {
  --   command = "codespell",
  --   ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
  --   filetypes = { "javascript", "python" },
  -- },
  {
    command = "eslint_d",
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "javascript", "javascriptreact" },
  },
}

-- Additional Plugins
lvim.plugins = {
  { "folke/tokyonight.nvim" },
  { "Shatur/neovim-ayu" },
  { "rebelot/kanagawa.nvim" },
  { "catppuccin/nvim" },
  -- { "karb94/neoscroll.nvim" },
  { "max397574/better-escape.nvim" },
  -- {

  --   cmd = "TroubleToggle",
  --   "folke/trouble.nvim",
  -- },
}
-- lua, default settings



-- require("better_escape").setup {
--   mapping = { '<esc>' }, -- a table with mappings to use
--   timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
--   clear_empty_lines = false, -- clear line after escaping if there is only whitespace
--   keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
--   -- example(recommended)
--   -- keys = function()
--   -- end,
--   --   return vim.api.nvim_win_get_cursor(0)[2] > 1 and '<esc>l' or '<esc>'

-- }
lvim.colorscheme = "kanagawa"

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })

--   -- All these keys will be mapped to their corresponding default scrolling animation
-- require('neoscroll').setup({
--   mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
--     '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
--   hide_cursor = true, -- Hide cursor while scrolling
--   stop_eof = true, -- Stop at <EOF> when scrolling downwards
--   respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
--   cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
--   use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
--   easing_function = "sine", -- Default easing function
--   pre_hook = nil, -- Function to run before the scrolling animation starts
--   post_hook = nil, -- Function to run after the scrolling animation ends
-- })
--   performance_mode = false, -- Disable "Performance Mode" on all buffers.
