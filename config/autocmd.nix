{
  autoGroups = {
    vim_enter = { };
    indentscope = { };
  };

  autoCmd = [
    {
      group = "indentscope";
      event = [ "FileType" ];
      pattern = [
        "help"
        "Startup"
        "startup"
        "neo-tree"
        "Trouble"
        "trouble"
        "notify"
      ];
      callback = {
        __raw = ''
          function()
            vim.b.miniindentscope_disable = true
          end
        '';
      };
    }
    {
      event = [ "TermOpen" ];
      pattern = [ "*" ];
      command = "startinsert";
    }
    {
      event = [ "BufEnter" ];
      pattern = [ "term://*" ];
      command = "startinsert";
    }
  ];
}
