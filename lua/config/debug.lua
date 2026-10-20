-- vim.lsp.set_log_level("debug")

-- -- Track LSP lifecycle
-- vim.api.nvim_create_autocmd("LspDetach", {
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     if client then
--       vim.notify(
--         string.format("[%s] LSP DETACHED: %s (buf %d)", os.date("%H:%M:%S"), client.name, args.buf),
--         vim.log.levels.WARN
--       )
--     end
--   end,
-- })
--
-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     vim.notify(
--       string.format("[%s] LSP attached: %s (buf %d)", os.date("%H:%M:%S"), client.name, args.buf),
--       vim.log.levels.INFO
--     )
--   end,
-- })
--
-- vim.api.nvim_create_user_command("LspForceAttach", function()
--   -- Clear and reload lspconfig
--   for name, _ in pairs(package.loaded) do
--     if name:match("^lspconfig") then
--       package.loaded[name] = nil
--     end
--   end
--
--   -- Trigger FileType event to reattach
--   vim.cmd("doautocmd FileType " .. vim.bo.filetype)
-- end, {})
--
-- vim.api.nvim_create_autocmd("LspDetach", {
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     if client then
--       -- Get stack trace to see what triggered the detach
--       vim.notify(
--         string.format(
--           "LSP DETACHED: %s (id=%d, buf=%d)\nStacktrace: %s",
--           client.name,
--           args.data.client_id,
--           args.buf,
--           debug.traceback()
--         ),
--         vim.log.levels.ERROR
--       )
--     end
--   end,
-- })

-- -- Add this to see what's calling vim.lsp.enable/disable
-- local original_enable = vim.lsp.enable
-- vim.lsp.enable = function(enable, filter)
--   if filter and filter.bufnr then
--     local bufname = vim.api.nvim_buf_get_name(filter.bufnr)
--     if bufname:match("%.py$") then
--       vim.notify(
--         string.format("vim.lsp.enable(%s) called on Python buffer!\nStacktrace: %s", enable, debug.traceback()),
--         vim.log.levels.WARN
--       )
--     end
--   end
--   return original_enable(enable, filter)
-- end

-- local original_buf_detach = vim.lsp.buf_detach_client
-- vim.lsp.buf_detach_client = function(bufnr, client_id)
--   local client = vim.lsp.get_client_by_id(client_id)
--   if client and client.name == "pyright" then
--     vim.notify(
--       string.format(
--         "buf_detach_client called for pyright!\nBuffer: %d\nStacktrace: %s",
--         bufnr,
--         debug.traceback("", 2) -- Start at caller level
--       ),
--       vim.log.levels.ERROR
--     )
--   end
--   return original_buf_detach(bufnr, client_id)
-- end

-- Auto-reattach all LSP clients after Git operations
vim.api.nvim_create_autocmd("LspDetach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    local buf = args.buf
    vim.schedule(function()
      if not vim.api.nvim_buf_is_valid(buf) then
        return
      end

      -- Check if this client is still running
      local clients = vim.lsp.get_clients({ name = client.name })
      if #clients > 0 then
        -- Reattach the existing client to the buffer
        vim.lsp.buf_attach_client(buf, clients[1].id)
        -- vim.notify(string.format("Reattached %s to buffer", client.name), vim.log.levels.INFO)
      end
    end)
  end,
})
