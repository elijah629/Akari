{ config, lib, ... }:
{
  plugins = {
    persistence = {
      enable = true;
    };
  };

  keymaps = lib.optionals config.plugins.persistence.enable [
    {
      mode = "n";
      key = "<leader>ql";
      action.__raw = "function() require('persistence').load() end";
      options.desc = "Load the session for the current directory";
    }
    {
      mode = "n";
      key = "<leader>qs";
      action.__raw = "function() require('persistence').select() end";
      options.desc = "Select a session to load";
    }
    {
      mode = "n";
      key = "<leader>qL";
      action.__raw = "function() require('persistence').load({ last = true }) end";
      options.desc = "Load the last session";
    }
    {
      mode = "n";
      key = "<leader>qS";
      action.__raw = "function() require('persistence').stop() end";
      options.desc = "Stop Persistence";
    }
  ];
}
