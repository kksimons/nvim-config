return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      eslint = {},
      denols = {
        root_dir = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc"),
        settings = {
          deno = {
            enable = true,
            suggest = {
              imports = {
                hosts = {
                  ["https://deno.land"] = true,
                  ["https://cdn.nest.land"] = true,
                  ["https://crux.land"] = true,
                },
              },
            },
          },
        },
      },
    },
    setup = {
      eslint = function()
        require("lazyvim.util").lsp.on_attach(function(client)
          if client.name == "eslint" then
            client.server_capabilities.documentFormattingProvider = true
          elseif client.name == "tsserver" then
            client.server_capabilities.documentFormattingProvider = false
          end
        end)
      end,
      -- LazyVim's built-in conflict prevention
      denols = function(_, opts)
        if LazyVim.lsp.is_enabled("denols") and LazyVim.lsp.is_enabled("vtsls") then
          local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
          LazyVim.lsp.disable("vtsls", is_deno)
          LazyVim.lsp.disable("denols", function(root_dir, config)
            if not is_deno(root_dir) then
              config.settings.deno.enable = false
            end
            return false
          end)
        end
      end,
    },
  },
}
