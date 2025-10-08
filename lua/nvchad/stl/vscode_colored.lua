local utils = require "nvchad.stl.utils"

local M = {}

M.mode = function()
  if not utils.is_activewin() then
    return ""
  end

  local modes = utils.modes
  local m = vim.api.nvim_get_mode().mode
  return "%#St_" .. modes[m][2] .. "mode#" .. "  " .. modes[m][1] .. " "
end

M.file = function()
  local x = utils.file()
  local name = " " .. x[2] .. " "
  return "%#StText# " .. x[1] .. name
end

M.git = utils.git
M.lsp_msg = utils.lsp_msg
M.diagnostics = utils.diagnostics

M.lsp = function()
  return "%#St_Lsp#" .. utils.lsp()
end

M.cursor = "%#StText# Ln %l, Col %v "
M["%="] = "%="

M.cwd = function()
  local name = vim.uv.cwd()
  name = "%#St_cwd# 󰉖 " .. (name:match "([^/\\]+)[/\\]*$" or name) .. " "
  return (vim.o.columns > 85 and name) or ""
end

M.rbg_status = function()
  local process_name = vim.g.rbg_process_name or "remedybg.exe"
  local is_running = utils.process_running(process_name)
  return "%#St_Lsp#RBG Status :: " .. (is_running and "True" or "False") .. " "
end

return function()
  return utils.generate("vscode", M)
end
