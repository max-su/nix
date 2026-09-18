{
  inputs,
  pkgs,
  ...
}:
let
  nixos = {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };
  homeManager = {
    pkgs,
    ...
  }:
  {
    imports = [
      inputs.lazyvim.homeManagerModules.default
    ];

    programs.lazyvim = {
      enable = true;

      extras = {
        lang = {
          nix.enable = true;
          python = {
            enable = true;
            installDependencies = true;
            installRuntimeDependencies = true;
          };
          rust.enable = true;
          go.enable = true;
        };
        editor = {
          fzf.enable = true;
        };
        coding = {
          mini-surround.enable = true;
        };
      };

      # IMPORTANT: Extras don't install treesitter parsers automatically
      # You must add them manually for syntax highlighting
      treesitterParsers = with pkgs.vimPlugins.nvim-treesitter-parsers; [
        nix
        python
        rust
        go
      ];

      extraPackages = with pkgs; [
        statix

        # LSP servers
        nixd

        # Formatters
        alejandra

        # Tools
        ripgrep
        fd

      ];

      config = {
        options = ''
          vim.opt.relativenumber = true
          vim.opt.wrap = true
        '';
        keymaps = ''
          -- Vertical split: Space + \
          vim.keymap.set("n", "<leader><BSlash>", "<Cmd>vsplit<CR>", { desc = "Split Window Vertically" })

          -- Horizontal split: Space + -
          vim.keymap.set("n", "<leader>-", "<Cmd>split<CR>", { desc = "Split Window Horizontally" })
        '';
      };

      plugins = {
        # colorscheme = ''
        #   return {
        #     "rose-pine/neovim",
        #     name = "rose-pine",
        #     config = function()
        #       vim.cmd("colorscheme rose-pine-moon")
        #     end
        #   }
        # '';
        colorscheme = ''
          return {
            "sainnhe/everforest",
            lazy = false,
            priority = 1000,
            config = function()
              vim.g.everforest_background = "hard"
              vim.opt.background = "dark"
              vim.cmd("colorscheme everforest")
            end
          }
        '';
        # tmux = ''
        #   return {
        #     "christoomey/vim-tmux-navigator",
        #     init = function()
        #       vim.g.tmux_navigator_no_mappings = 1
        #     end,
        #     cmd = {
        #       "TmuxNavigateLeft",
        #       "TmuxNavigateDown",
        #       "TmuxNavigateUp",
        #       "TmuxNavigateRight",
        #       "TmuxNavigatePrevious",
        #     },
        #     keys = {
        #       { "<c-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Navigate Left (Vim/Tmux)" },
        #       { "<c-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Navigate Down (Vim/Tmux)" },
        #       { "<c-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Navigate Up (Vim/Tmux)" },
        #       { "<c-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Navigate Right (Vim/Tmux)" },
        #     },
        #   }
        # '';
        navigation = ''
          return {
            'lmilojevicc/herdr-splits.nvim',
            -- For local development, swap the repo line for `dir = '/path/to/herdr-splits'`
            -- (see "Local development" below).
            cond = vim.env.HERDR_ENV == '1',
            event = 'VeryLazy',
            -- Optional: auto-sync the Herdr-side scripts when lazy updates this plugin.
            -- Requires `auto_sync_herdr = true` in setup() below to take effect.
            -- build = ':lua require("herdr-splits").sync_herdr()',
            config = function()
              require('herdr-splits').setup({
                -- Defaults shown. All fields optional.
                default_amount = 0.03,       -- Herdr resize ratio
                neovim_amount = 3,           -- Neovim resize cells
                at_edge = 'wrap',            -- 'wrap' | 'stop' | 'split' | function
                ignored_buftypes = { 'nofile', 'quickfix', 'prompt', 'help', 'terminal' },
                ignored_filetypes = {
                  'NvimTree',
                  -- sidebars
                  'neo-tree',
                  'snacks_dashboard',
                  'snacks_explorer',
                  'snacks_picker',
                  -- DB / REPL / data sidebars
                  'dadbod-ui',
                  'dbout',
                  -- outlines / symbols
                  'aerial',
                  'Outline',
                  -- diagnostics / quick lists
                  'Trouble',
                  'quickfix',
                },
                move_cursor_same_row = false,
                herdr_bin = nil,                -- auto-detected from HERDR_BIN_PATH
                floating_zindex_max = 50,       -- floats with zindex < this are treated as embedded sidebars
                ignore_previewwindows = false,  -- opt-in: also treat previewwindow windows (e.g. .dbout) as sidebars
                -- auto_sync_herdr = true,      -- opt-in: sync Herdr-side scripts on update
                -- Managed keys — written to the generated herdr-splits.conf so the
                -- Herdr-side scripts agree. Pass Neovim notation (e.g. <M-Left>).
                nav_keys    = { left = '<C-h>', down = '<C-j>', up = '<C-k>', right = '<C-l>' },
                resize_keys = { left = '<M-h>', down = '<M-j>', up = '<M-k>', right = '<M-l>' },
                unzoom_on_nav = true,   -- auto-unzoom when navigating away from a zoomed pane
                nav_at_edge    = 'wrap', -- 'wrap' | 'stop' — Herdr pane-boundary wrap (distinct from at_edge)
              })
            end,
            keys = {
              { '<C-h>', function() require('herdr-splits').move_cursor_left() end,  desc = 'Navigate left' },
              { '<C-j>', function() require('herdr-splits').move_cursor_down() end,  desc = 'Navigate down' },
              { '<C-k>', function() require('herdr-splits').move_cursor_up() end,    desc = 'Navigate up' },
              { '<C-l>', function() require('herdr-splits').move_cursor_right() end, desc = 'Navigate right' },
              { '<M-h>', function() require('herdr-splits').resize_left() end,  desc = 'Resize left' },
              { '<M-j>', function() require('herdr-splits').resize_down() end,  desc = 'Resize down' },
              { '<M-k>', function() require('herdr-splits').resize_up() end,    desc = 'Resize up' },
              { '<M-l>', function() require('herdr-splits').resize_right() end, desc = 'Resize right' },
            },
          }
        '';
        python-diagnostics = ''
          return {
            "neovim/nvim-lspconfig",
            opts = {
              servers = {
                pyright = {
                  settings = {
                    pyright = {
                      disableOrganizeImports = true,
                    },
                  },
                },
                ruff = {
                  init_options = {
                    settings = {
                      args = { "--select=E,W,I,F401,F841" },
                    },
                  },
                },
              },
            },
          }
        '';
        bufferline = ''
          return {
            "akinsho/bufferline.nvim",
            opts = {
              highlights = {
                fill = {
                  bg = "NONE",
                },
              },
            },
          }
        '';
      };
    };
  };
in
{
  flake.modules.nixos.base.imports = [ nixos ];
  flake.modules.homeManager.frieren.imports = [ homeManager ];
}
