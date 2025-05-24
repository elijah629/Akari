{
  plugins.blink-cmp = {
    enable = true;

    settings = {
      completion = {
        accept.auto_brackets.enabled = true;
        ghost_text.enabled = true;

        documentation = {
          auto_show = true;
          window.border = "rounded";
        };

        list.selection = {
          preselect = false;
        };

        menu = {
          border = "rounded";

          draw = {
            columns = [
              {
                __unkeyed-1 = "label";
              }
              {
                __unkeyed-1 = "kind_icon";
                __unkeyed-2 = "kind";
                gap = 1;
              }
              { __unkeyed-1 = "source_name"; }
            ];

            components = {
              kind_icon = {
                text.__raw = ''
                  function(ctx)
                    local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                    return kind_icon
                  end
                '';
                highlight.__raw = ''
                  function(ctx)
                    local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                    return hl
                  end
                '';
              };

              kind = {
                highlight.__raw = ''
                  function(ctx)
                    local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                    return hl
                  end
                '';
              };
            };
          };
        };
      };
    };
  };
  /*
    settings = {
            completion = {
              accept.auto_brackets.enabled = true;
              ghost_text.enabled = true;
              documentation = {
                auto_show = true;
                window.border = "rounded";
              };
              list.selection = {
                preselect = false;
              };
              menu = {
                border = "rounded";
                draw = {
                  /*
                    columns = [
                      {
                        __unkeyed-1 = "label";
                      }
                      {
                        __unkeyed-1 = "kind_icon";
                        __unkeyed-2 = "kind";
                        gap = 1;
                      }
                      { __unkeyed-1 = "source_name"; }
                    ];
                  __COMMENT__
                  components = {
                    kind_icon = {
                      #ellipsis = false;
                      text.__raw = ''
                        function(ctx)
                          local icon = ctx.kind_icon
                          if vim.tbl_contains({ "Path" }, ctx.source_name) then
                              local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                              if dev_icon then
                                  icon = dev_icon
                              end
                          else
                              icon = require("lspkind").symbolic(ctx.kind, {
                                  mode = "symbol",
                              })
                          end

                          return icon .. ctx.icon_gap
                        end
                      '';

                      highlight.__raw = ''
                        function(ctx)
                          local hl = ctx.kind_hl
                          if vim.tbl_contains({ "Path" }, ctx.source_name) then
                            local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                            if dev_icon then
                              hl = dev_hl
                            end
                          end
                          return hl
                        end
                      '';
                    };
                  };
                };
              };
            };
            fuzzy = {
              implementation = "rust";
              prebuilt_binaries = {
                download = false;
              };
            };
            appearance = {
              use_nvim_cmp_as_default = true;
            };
            keymap = {
              preset = "enter";
              "<C-Up>" = [
                "snippet_forward"
                "fallback"
              ];
              "<C-Down>" = [
                "snippet_backward"
                "fallback"
              ];
              "<Tab>" = [
                "select_next"
                "fallback"
              ];
              "<S-Tab>" = [
                "select_prev"
                "fallback"
              ];
            };
            signature = {
              enabled = true;
              window.border = "rounded";
            };
            snippets.preset = "mini_snippets";
            sources = {
              default = [
                "buffer"
                "dictionary"
                "emoji"
                "lsp"
                "path"
                "snippets"
              ];
              providers = {
                lsp.score_offset = 4;
                buffer = {
                  opts = {
                    # Get suggestions from all "normal" open buffers
                    get_bufnrs.__raw = ''
                      function()
                        return vim.tbl_filter(function(bufnr)
                          return vim.bo[bufnr].buftype == ""
                        end, vim.api.nvim_list_bufs())
                       end
                    '';
                  };
                };
                dictionary = {
                  name = "Dict";
                  module = "blink-cmp-dictionary";
                  min_keyword_length = 3;
                };
                emoji = {
                  name = "Emoji";
                  module = "blink-emoji";
                  score_offset = 1;
                };
              }
              /*
                // lib.optionalAttrs config.plugins.blink-compat.enable {
                  calc = {
                    name = "calc";
                    module = "blink.compat.source";
                    score_offset = 2;
                  };
                })
              __COMMENT__
              ;
            };
          };
        };

        blink-cmp-dictionary.enable = true;
        blink-emoji.enable = true;
        # blink-compat.enable = true;
      }
      /*
        (lib.mkIf config.plugins.blink-cmp.enable {
          cmp-calc.enable = true;
        })

    ];
  */
}
