for _, spec in pairs(Plug.specs) do
    setmetatable(spec, {})
end

return _G.Plug.specs
