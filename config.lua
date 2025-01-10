-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.colorscheme = "nordic"

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.guifont = "monospace:h17"
vim.opt.clipboard = "unnamedplus"

lvim.keys.insert_mode["jk"] = "<Esc>"
lvim.keys.insert_mode["kj"] = "<Esc>"

vim.api.nvim_create_autocmd("BufLeave", {
    callback = function()
        vim.cmd("silent! write")
    end,
})

lvim.builtin.indentlines.active = true
lvim.colorscheme = "tokyonight"
lvim.use_icons = true

lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true

lvim.builtin.bufferline.active = true
--lvim.builtin.autosave.active = true
lvim.builtin.gitsigns.active = true

--Prettier like formatting for js and such
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({ { command = "prettier", filetypes = { "javascript", "typescript", "html", "css" } } })

--Save Keybind
lvim.keys.normal_mode["<C-s>"] = ":w<CR>"

--Window movement
lvim.keys.normal_mode["<C-h>"] = "<C-w>h"
lvim.keys.normal_mode["<C-l>"] = "<C-w>l"
lvim.keys.normal_mode["<C-j>"] = "<C-w>j"
lvim.keys.normal_mode["<C-k>"] = "<C-w>k"


--Github Copilot Implementation
lvim.plugins = {
    { "github/copilot.vim" },
    { "AlexvZyl/nordic.nvim" },
    {
      'wfxr/minimap.vim',
      build = "cargo install --locked code-minimap",
      -- cmd = {"Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight"},
      config = function ()
        vim.cmd ("let g:minimap_width = 10")
        vim.cmd ("let g:minimap_auto_start = 1")
        vim.cmd ("let g:minimap_auto_start_win_enter = 1")
      end,
    },
    {
      "norcalli/nvim-colorizer.lua",
        config = function()
          require("colorizer").setup({ "css", "scss", "html", "javascript" }, {
              RGB = true, -- #RGB hex codes
              RRGGBB = true, -- #RRGGBB hex codes
              RRGGBBAA = true, -- #RRGGBBAA hex codes
              rgb_fn = true, -- CSS rgb() and rgba() functions
              hsl_fn = true, -- CSS hsl() and hsla() functions
              css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
              css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
              })
      end,
    },
    {
      "Pocco81/auto-save.nvim",
      config = function()
        require("auto-save").setup()
      end,
    },
    {
      "karb94/neoscroll.nvim",
      event = "WinScrolled",
      config = function()
      require('neoscroll').setup({
            -- All these keys will be mapped to their corresponding default scrolling animation
            mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
            '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
            hide_cursor = true,          -- Hide cursor while scrolling
            stop_eof = false,             -- Stop at <EOF> when scrolling downwards
            use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
            respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
            cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
            easing_function = nil,        -- Default easing function
            pre_hook = nil,              -- Function to run before the scrolling animation starts
            post_hook = nil,              -- Function to run after the scrolling animation ends
            })
      end
    },
}

table.insert(lvim.plugins, {
  "zbirenbaum/copilot-cmp",
  event = "InsertEnter",
  dependencies = { "zbirenbaum/copilot.lua" },
  config = function()
    vim.defer_fn(function()
      require("copilot").setup() -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
      require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
    end, 100)
  end,
})

