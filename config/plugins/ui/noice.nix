{ config, lib, ... }:
{
  plugins = {
    noice = {
      enable = true;

      settings = {
        # Hides the title above noice boxes
        cmdline = {
          format = {
            cmdline = {
              pattern = "^:";
              icon = "";
              lang = "vim";
              opts = {
                border = {
                  text = {
                    top = "Cmd";
                  };
                };
              };
            };
            search_down = {
              kind = "search";
              pattern = "^/";
              icon = " ";
              lang = "regex";
            };
            search_up = {
              kind = "search";
              pattern = "^%?";
              icon = " ";
              lang = "regex";
            };
            filter = {
              pattern = "^:%s*!";
              icon = "";
              lang = "bash";
              opts = {
                border = {
                  text = {
                    top = "Bash";
                  };
                };
              };
            };
            lua = {
              pattern = "^:%s*lua%s+";
              icon = "";
              lang = "lua";
            };
            help = {
              pattern = "^:%s*he?l?p?%s+";
              icon = "󰋖";
            };
            input = { };
          };
        };

        messages = {
          view = "mini";
          view_error = "mini";
          view_warn = "mini";
        };

        lsp = {
          override = {
            "vim.lsp.util.convert_input_to_markdown_lines" = true;
            "vim.lsp.util.stylize_markdown" = true;
            "cmp.entry.get_documentation" = true;
          };

          progress.enabled = true;
          signature.enabled = !config.plugins.lsp-signature.enable;
        };

        popupmenu.backend = "nui";
        # Doesn't support the standard cmdline completions
        # popupmenu.backend = "cmp";

        presets = {
          bottom_search = false;
          command_palette = true;
          long_message_to_split = true;
          inc_rename = true;
          lsp_doc_border = true;
        };

        routes = [
          {
            filter = {
              event = "msg_show";
              kind = "search_count";
            };
            opts = {
              skip = true;
            };
          }
          {
            # skip progress messages from noisy servers
            filter = {
              event = "lsp";
              kind = "progress";
              cond.__raw = ''
                function(message)
                  local client = vim.tbl_get(message.opts, 'progress', 'client')
                  local servers = { 'jdtls' }

                  for index, value in ipairs(servers) do
                      if value == client then
                          return true
                      end
                  end
                end
              '';
            };
            opts = {
              skip = true;
            };
          }
        ];
      };
    };

    notify.enable = true;
  };

  keymaps = lib.mkIf config.plugins.noice.enable [
    {
      mode = "n";
      key = "<leader>fn";
      action =
        let
          # Determine the action based on priority
          hasSnacksPicker =
            config.plugins.snacks.enable && lib.hasAttr "picker" config.plugins.snacks.settings;
          hasFzfLua = config.plugins.fzf-lua.enable;
          hasTelescope = config.plugins.telescope.enable;
        in
        if hasSnacksPicker then
          "<cmd>Noice snacks<CR>"
        else if hasFzfLua then
          "<cmd>Noice fzf<CR>"
        else if hasTelescope then
          "<cmd>Telescope noice<CR>"
        else
          "<cmd>Noice<CR>"; # Fallback to basic Noice command
      options = {
        desc = "Find notifications";
      };
    }
  ];
}

/*
  { config, lib, ... }:
  {
    plugins.noice = {
      enable = true;
      settings = {
        lsp = {
          override = {
            "vim.lsp.util.convert_input_to_markdown_lines" = true;
            "vim.lsp.util.stylize_markdown" = true;
            "cmp.entry.get_documentation" = true;
          };
          notify.enabled = true;
          progress.enabled = true;
          signature.enabled = !config.plugins.lsp-signature.enable;
        };

        presets = {
          bottom_search = false;
          command_palette = true;
          long_message_to_split = true;
          inc_rename = true;
          lsp_doc_border = true;
        };

        routes = [
          {
            filter = {
              event = "msg_show";
              any = [
                { find = "%d+L, %d+B"; }
                { find = "; after #%d+"; }
                { find = "; before #%d+"; }
              ];
            };
            view = "mini";
          }
        ];
      };
    };
    keymaps = lib.mkIf (config.plugins.telescope.enable && config.plugins.noice.enable) [
      {
        mode = "n";
        key = "<leader>sn";
        action = "<cmd>Telescope noice<CR>";
        options = {
          desc = "Find notifications";
        };
      }
    ];
  }
*/
