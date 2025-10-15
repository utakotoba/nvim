local r = require 'internal.stl.providers'
local base = require 'internal.stl.base'

local M = {}

M.providers = {
  r.space(),
  r.modeinfo(),
  r.separator(),
  r.filename(),
}

function M.load()
  -- attach providers to user interface
  base.attach_providers(M.providers)
end

return M
