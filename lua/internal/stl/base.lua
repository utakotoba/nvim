-- modified from Kicamon's nvim configuration
-- source: https://github.com/Kicamon/nvim

local co, api, iter = coroutine, vim.api, vim.iter

local M = {}

--- Format a string with a highlight group for statusline
--- @param name string Hightlight group name
--- @param val string Text to display
function M.stl_format(name, val)
  return '%#Status' .. name .. '#' .. val .. '%*'
end

--- Get hightlight attributes for a given group
--- @param group string Hightlight group name
--- @return table {fg=?, bg=?}
function M.stl_attr(group)
  local hl = api.nvim_get_hl(0, {
    name = group,
    link = false,
  })
  local hl_stl = api.nvim_get_hl(0, {
    name = 'StatusLine',
  })

  return { fg = hl.fg, bg = hl_stl.bg }
end

--- A provider spec describes one segment of the statusline
--- @class ProviderSpec
--- @field name string Unique name for hightlight identification
--- @field stl string|fun(args:table):string String of function describes content
--- @field event? string[] Optional list of events to listen
--- @field attr? table Optional hightlihgt table
--- @field default? string Optional default value to show
--- @diagnostic disable-next-line: unused
local ProviderSpec = {}

--- Helper function to create a ProviderSpec
--- @param name string Unique name for hightlight identification
--- @param stl string|fun(args:table):string String of function describes content
--- @param attr? table Optional hightlihgt table
--- @param event? string[] Optional list of events to listen
--- @param default? string Optional default value to show
--- @return ProviderSpec
function M.create_provider(name, stl, attr, event, default)
  return {
    name = name,
    stl = stl,
    attr = attr,
    event = event,
    default = default,
  }
end

--- Prepare for status layout
--- @param providers ProviderSpec[] List of providers to apply layout with
--- @return ProviderSpec[] comps
--- @return table<string, integer[]> events
--- @return string[] pieces
local function apply_layout(providers)
  local e, pieces = {}, {}

  iter(ipairs(providers))
    :map(function(idx, item)
      if item.attr and item.name then
        api.nvim_set_hl(0, ('Status%s'):format(item.name), item.attr)
      end

      if type(item.stl) == 'string' then
        pieces[#pieces + 1] = M.stl_format(item.name, item.stl)
      elseif type(item.stl) == 'function' then
        pieces[#pieces + 1] = item.default
            and M.stl_format(item.name, item.default)
          or ''
      end

      for _, event in ipairs(item.event or {}) do
        e[event] = e[event] or {}
        e[event][#e[event] + 1] = idx
      end
    end)
    :totable()

  return providers, e, pieces
end

--- Render statusline on events in coroutine
--- @param providers ProviderSpec[] List of providers to render
--- @param events table<string, integer[]>
--- @param pieces string[]
--- @return thread Coroutine for rendering
local function render(providers, events, pieces)
  return co.create(function(args)
    while true do
      -- get full event name for User event
      local event = args.event == 'User' and args.event .. ' ' .. args.match
        or args.event
      for _, idx in ipairs(events[event] or {}) do
        local provider = providers[idx]
        --- @diagnostic disable: need-check-nil
        local val --- @type string
        if type(provider.stl) == 'function' then
          val = provider.stl(args)
        else
          --- @diagnostic disable-next-line: assign-type-mismatch
          val = provider.stl
        end
        --- @diagnostic disable-next-line: param-type-not-match
        pieces[idx] = M.stl_format(provider.name, val)
      end

      -- render statusline
      vim.opt.stl = table.concat(pieces)
      args = co.yield()
    end
  end)
end

--- Attach providers to their events
--- @param providers ProviderSpec[] List of providers to attach
function M.attach_providers(providers)
  local comps, events, pieces = apply_layout(providers)
  local stl_render = render(comps, events, pieces)

  for _, e in ipairs(vim.tbl_keys(events)) do
    local pattern -- default to nil
    local event_type = e
    if e:find 'User' then
      pattern = vim.split(e, '%s')[2]
      event_type = 'User'
    end

    --- @diagnostic disable-next-line: param-type-not-match
    api.nvim_create_autocmd(event_type, {
      pattern = pattern,
      callback = function(args)
        vim.schedule(function()
          local ok, res = co.resume(stl_render, args)
          if not ok then
            vim.notify(
              '[Statusline] rendering failed ' .. res,
              vim.log.levels.ERROR
            )
          end
        end)
      end,
    })
  end
end

return M
