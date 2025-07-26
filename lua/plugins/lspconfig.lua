return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      eslint = {},
      vtsls = {
        root_dir = function(fname)
          local util = require("lspconfig.util")
          -- Return nil if deno config is present
          if util.root_pattern("deno.json", "deno.jsonc")(fname) then
            return nil
          end
          return util.root_pattern("package.json", "tsconfig.json", ".git")(fname)
        end,
      },
      -- denols only in deno projects
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
      denols = nil,
    },
  },
}
