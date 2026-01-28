-- lua/plugins/lsp.lua
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      { "j-hui/fidget.nvim", opts = {} }, -- UI for LSP progress
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      -- Capabilities for cmp
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- Setup Mason
      mason.setup()
      mason_lspconfig.setup({
        ensure_installed = {
          "vtsls",        -- TypeScript (Better than tsserver)
          "pyright",      -- Python
          "lua_ls",       -- Lua
          "jsonls",       -- JSON
          "gopls",        -- Go
          -- "eslint",    -- ESLint (Can be added if needed)
        },
        handlers = {
          function(server_name)
            lspconfig[server_name].setup({
              capabilities = capabilities,
            })
          end,

          -- Lua specific settings
          ["lua_ls"] = function()
            lspconfig.lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  diagnostics = { globals = { "vim" } },
                  workspace = {
                    library = {
                      [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                      [vim.fn.stdpath("config") .. "/lua"] = true,
                    },
                  },
                },
              },
            })
          end,
          
          -- Vtsls specific settings (optional customization)
          ["vtsls"] = function()
             lspconfig.vtsls.setup({
                capabilities = capabilities,
                settings = {
                   typescript = {
                      inlayHints = {
                         parameterNames = { enabled = "literals" },
                         parameterTypes = { enabled = true },
                         variableTypes = { enabled = false },
                         propertyDeclarationTypes = { enabled = true },
                         functionLikeReturnTypes = { enabled = true },
                         enumMemberValues = { enabled = true },
                      }
                   }
                }
             })
          end
        },
      })

      -- Keymaps on LspAttach
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }
          local map = vim.keymap.set

          opts.desc = "Go to definition"
          map("n", "gd", vim.lsp.buf.definition, opts)

          opts.desc = "Go to declaration"
          map("n", "gD", vim.lsp.buf.declaration, opts)

          opts.desc = "Go to references"
          map("n", "gr", vim.lsp.buf.references, opts)

          opts.desc = "Go to implementation"
          map("n", "gi", vim.lsp.buf.implementation, opts)

          opts.desc = "Hover documentation"
          map("n", "K", vim.lsp.buf.hover, opts)

          opts.desc = "Signature help"
          map("n", "<C-k>", vim.lsp.buf.signature_help, opts)

          opts.desc = "Rename"
          map("n", "<leader>rn", vim.lsp.buf.rename, opts)

          opts.desc = "Code action"
          map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

          opts.desc = "Diagnostics"
          map("n", "<leader>d", vim.diagnostic.open_float, opts)
          map("n", "[d", vim.diagnostic.goto_prev, opts)
          map("n", "]d", vim.diagnostic.goto_next, opts)
        end,
      })
    end,
  },
}
