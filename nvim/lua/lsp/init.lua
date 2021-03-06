-- Mappings.
local keymap_opts = { noremap=true, silent=true }
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', keymap_opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', keymap_opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', keymap_opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', keymap_opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', keymap_opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', keymap_opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', keymap_opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', keymap_opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', keymap_opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', keymap_opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', keymap_opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', keymap_opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', keymap_opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', keymap_opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', keymap_opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end
end


require('lsp/lua-ls')

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers = { "gopls", "tsserver", "clojure_lsp" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

local map = vim.api.nvim_set_keymap
-- Find files using Telescope command-line sugar.
map('n', '<leader><Space>', '<cmd>lua require("telescope_config").project_files()<CR>', keymap_opts)
map('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', keymap_opts)
map('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>', keymap_opts)
map('n', '<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>', keymap_opts)
map('n', '<leader>ff', '<cmd>lua require("telescope.builtin").file_browser()<cr>', keymap_opts)

map('n', '<leader>fr', '<cmd>lua require("telescope.builtin").lsp_references()<cr>', keymap_opts)
map('n', '<leader>caw', '<cmd>lua require("telescope.builtin").lsp_workspace_diagnostics()<cr>', keymap_opts)
map('n', '<leader>cad', '<cmd>lua require("telescope.builtin").lsp_document_diagnostics()<cr>', keymap_opts)
