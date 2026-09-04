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
        colorscheme = ''
          return {
            "rose-pine/neovim",
            name = "rose-pine",
            config = function()
              vim.cmd("colorscheme rose-pine-moon")
            end
          }
        '';
        tmux = ''
          return {
            "christoomey/vim-tmux-navigator",
            init = function()
              vim.g.tmux_navigator_no_mappings = 1
            end,
            cmd = {
              "TmuxNavigateLeft",
              "TmuxNavigateDown",
              "TmuxNavigateUp",
              "TmuxNavigateRight",
              "TmuxNavigatePrevious",
            },
            keys = {
              { "<c-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Navigate Left (Vim/Tmux)" },
              { "<c-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Navigate Down (Vim/Tmux)" },
              { "<c-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Navigate Up (Vim/Tmux)" },
              { "<c-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Navigate Right (Vim/Tmux)" },
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
      };
    };
  };
in
{
  flake.modules.nixos.base.imports = [ nixos ];
  flake.modules.homeManager.frieren.imports = [ homeManager ];
}
