/*
  { icons, ... }:
  {
    plugins.lualine = {
      enable = true;
      settings = {
        options = {
          always_divide_middle = true;
          ignore_focus = [ "neo-tree" ];
          globalstatus = true; # have a single statusline at bottom of neovim instead of one for every window
          disabled_filetypes.statusline = [
            "dashboard"
            "alpha"
          ];
          section_separators = {
            left = "";
            right = "";
          };
        };
        extensions = [ "fzf" ];
        sections = {
          lualine_a = [ "mode" ];
          lualine_b = [ "branch" ];

          lualine_y = [
            {
              __unkeyed = "progress";
              separator = "";
            }
            {
              __unkeyed = "location";
              separator = "";
              padding = {
                left = 0;
                right = 1;
              };
            }
          ];
          lualine_z = [
            ''"${icons.ui.Time}" .. os.date("%R")''
          ];
        };
      };
    };
    extraConfigLua = ''
        local ui = {}

        function ui.fg(name)
          local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name }) or vim.api.nvim_get_hl_by_name(name, true)
          local fg = hl and (hl.fg or hl.foreground)
          return fg and { fg = string.format("#%06x", fg) } or nil
        end

        ---@param opts? {relative: "cwd"|"root", modified_hl: string?}
        function ui.pretty_path(opts)
          opts = vim.tbl_extend("force", {
            relative = "cwd",
            modified_hl = "Constant",
          }, opts or {})

          return function(self)
            local path = vim.fn.expand("%:p") --[[@as string]]

            if path == "" then
              return ""
            end

            local bufname = vim.fn.bufname(vim.fn.bufnr())
            local sep = package.config:sub(1, 1)

            local root = (opts.relative == "root") and vim.fn.getcwd() or vim.fn.fnamemodify(bufname, ":h")
            local cwd = vim.fn.getcwd()

            path = (opts.relative == "cwd" and path:find(cwd, 1, true) == 1) and path:sub(#cwd + 2) or path:sub(#root + 2)

            local parts = vim.split(path, "[\\/]")
            if #parts > 3 then
              parts = { parts[1], "…", parts[#parts - 1], parts[#parts] }
            end

            if opts.modified_hl and vim.bo.modified then
              local modified_hl_fg = ui.fg(opts.modified_hl)
              if modified_hl_fg then
                parts[#parts] = string.format("%%#%s#%s%%*", opts.modified_hl, parts[#parts])
              end
            end

            return table.concat(parts, sep)
          end
        end

        require("lualine").setup({
            sections = {
              lualine_c = {
                  {
                    "diagnostics",
                    symbols = {
                      error = "${icons.diagnostics.Error}",
                      warn  = "${icons.diagnostics.Warning}",
                      hint  = "${icons.diagnostics.Hint}",
                      info  = "${icons.diagnostics.BoldInformation}",
                    },
                    separator = ")"
                  },
                  { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                  { ui.pretty_path() },
              },

            lualine_x = {
                {
                  function() return require("noice").api.status.command.get() end,
                  cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
                  color = ui.fg("Statement"),
                  separator = "(",
                },
                {
                  function() return require("noice").api.status.mode.get() end,
                  cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                  color = ui.fg("Constant"),
                  separator = "(",
                },
                {
                    function()
                        local msg = ""
                        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                        local clients = vim.lsp.get_active_clients()
                        if next(clients) == nil then
                            return msg
                        end
                        for _, client in ipairs(clients) do
                            local filetypes = client.config.filetypes
                            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                                return client.name
                            end
                        end
                        return msg
                    end,

                    color = ui.fg("StatusLine"),
                    separator = "(",
                },
                {
                "diff",
                symbols = {
                  added = "${icons.git.LineAdded}",
                  modified = "${icons.git.LineModified}",
                  removed= "${icons.git.LineRemoved}",
                  },
                },
            }
        }
      })
    '';
  }
*/

{ config, lib, ... }:
let
  cond.__raw = ''
    function()
      local cache = {}
      return function()
        local bufnr = vim.api.nvim_get_current_buf()
        if cache[bufnr] == nil then
          local buf_size = vim.api.nvim_buf_get_offset(bufnr, vim.api.nvim_buf_line_count(bufnr))
          cache[bufnr] = buf_size < 1024 * 1024 -- 1MB limit
          -- Clear cache on buffer unload
          vim.api.nvim_create_autocmd("BufUnload", {
            buffer = bufnr,
            callback = function() cache[bufnr] = nil end,
          })
        end
        return cache[bufnr]
      end
    end
  '';
in
{
  plugins.lualine = {
    enable = true;

    lazyLoad.settings.event = [
      "VimEnter"
      "BufReadPost"
      "BufNewFile"
    ];

    settings = {
      options = {
        disabled_filetypes = {
          __unkeyed-1 = "startify";
          __unkeyed-2 = "neo-tree";
          __unkeyed-3 = "copilot-chat";
          __unkeyed-4 = "ministarter";
          __unkeyed-5 = "Avante";
          __unkeyed-6 = "AvanteInput";
          __unkeyed-7 = "trouble";
          __unkeyed-8 = "dapui_scopes";
          __unkeyed-9 = "dapui_breakpoints";
          __unkeyed-10 = "dapui_stacks";
          __unkeyed-11 = "dapui_watches";
          __unkeyed-12 = "dapui_console";
          __unkeyed-13 = "dashboard";
          __unkeyed-14 = "snacks_dashboard";
          __unkeyed-15 = "AvanteSelectedFiles";
          winbar = [
            "aerial"
            "dap-repl"
            "dap-view"
            "dap-view-term"
            "neotest-summary"
          ];
        };

        globalstatus = true;
      };

      # +-------------------------------------------------+
      # | A | B | C                             X | Y | Z |
      # +-------------------------------------------------+
      sections = {
        lualine_a = [ "mode" ];
        lualine_b = [ "branch" ];
        lualine_c = [
          "filename"
          "diff"
        ];

        lualine_x = [
          { __raw = ''Snacks.profiler.status()''; }
          {
            __unkeyed-1 = "diagnostics";
            # TODO: figure out how this works
            # It's triplicating number count
            # sources = [
            #   "nvim_lsp"
            #   "nvim_diagnostic"
            #   "nvim_workspace_diagnostic"
            # ];
            diagnostics_color = {
              error = {
                fg = "#ed8796";
              };
              warn = {
                fg = "#eed49f";
              };
              info = {
                fg = "#8aadf4";
              };
              hint = {
                fg = "#a6da95";
              };
            };
            colored = true;
          }

          # Show active language server
          (lib.optionalString config.plugins.copilot-lua.enable "copilot")
          {
            __unkeyed-1.__raw = ''
              function()
                  local msg = ""
                  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                  local clients = vim.lsp.get_active_clients()
                  if next(clients) == nil then
                      return msg
                  end
                  for _, client in ipairs(clients) do
                      local filetypes = client.config.filetypes
                      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                          return client.name
                      end
                  end
                  return msg
              end
            '';
            icon = "";
            color.fg = "#ffffff";
          }
          "encoding"
          "fileformat"
          "filetype"
        ];

        lualine_y = [
          (lib.mkIf config.plugins.aerial.enable {
            __unkeyed-1 = "aerial";
            colored = true;

            depth = 3; # Limit depth for better performance
            dense = true; # Better for performance
            dense_sep = ".";

            cond.__raw = ''
              function()
                local aerial_avail, aerial = pcall(require, "aerial")
                return aerial_avail and aerial.has_symbols()
              end
            '';
          })
        ];

        lualine_z = [
          {
            __unkeyed-1 = "location";
            inherit cond;
          }
        ];
      };

      tabline = lib.mkIf (!config.plugins.bufferline.enable) {
        lualine_a = [
          # NOTE: not high priority since i use bufferline now, but should fix left separator color
          {
            __unkeyed-1 = "buffers";
            symbols = {
              alternate_file = "";
            };
          }
        ];
        lualine_z = [ "tabs" ];
      };

      winbar = {
        lualine_c = [
          (lib.mkIf config.plugins.navic.enable {
            __unkeyed-1 = "navic";
            inherit cond;
            color_correction = "static";
            navic_opts = {
              highlight = true;
              depth_limit = 5;
              depth_limit_indicator = "...";
            };
          })
        ];

        # TODO: Need to dynamically hide/show component so navic takes precedence on smaller width
        lualine_x = [
          {
            __unkeyed-1 = "filename";
            newfile_status = true;
            path = 3;
            # Shorten path names to fit navic component
            shorting_target = 150;
            symbols = {
              modified = "";
              readonly = "";
              newfile = "";
            };
          }
        ];
      };
    };
  };
}
