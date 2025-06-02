/*
  _: {
    plugins.toggleterm = {
      enable = true;
      settings = {
        size = ''
          function(term)
            if term.direction == "horizontal" then
              return 30
          elseif term.direction == "vertical" then
              return vim.o.columns * 0.4
            end
          end
        '';

        start_in_insert = true;
        persist_mode = false;

        close_on_exit = true;
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<C-/>";
        action = "<cmd>ToggleTerm<cr><C-\\><C-n>i";
        options = {
          desc = "Toggle Terminal Window";
        };
      }
      {
        mode = "n";
        key = "<leader>tv";
        action = "<cmd>ToggleTerm direction=vertical<cr>";
        options = {
          desc = "Toggle Vertical Terminal Window";
        };
      }
      {
        mode = "n";
        key = "<leader>th";
        action = "<cmd>ToggleTerm direction=horizontal<cr>";
        options = {
          desc = "Toggle Horizontal Terminal Window";
        };
      }
      {
        mode = "n";
        key = "<leader>tf";
        action = "<cmd>ToggleTerm direction=float<cr>";
        options = {
          desc = "Toggle Floating Terminal Window";
        };
      }
    ];
  }
*/

{ config, lib, ... }:
{
  plugins.toggleterm = {
    enable = true;

    lazyLoad = {
      settings = {
        cmd = "ToggleTerm";
        keys = [
          "<leader>tg"
          "<leader>gg"
        ];
      };
    };

    settings = {
      direction = "float";
    };
  };

  keymaps = lib.mkIf config.plugins.toggleterm.enable [
    {
      mode = [
        "n"
        "t"
        "i"
      ];
      key = "<C-/>";
      action = "<cmd>ToggleTerm<CR>";
      options = {
        desc = "Open Terminal";
      };
    }
  ];
}
