local old_set_physics_override
local function new_set_physics_override(self, speed, jump, gravity)
    if type(speed) == "table" then
        return old_set_physics_override(self, speed)
    end

    local overrides = {}
    if speed ~= nil then
        overrides.speed = speed
    end
    if jump ~= nil then
        overrides.jump = jump
    end
    if gravity ~= nil then
        overrides.gravity = gravity
    end

    return old_set_physics_override(self, overrides)
end

minetest.register_on_joinplayer(function(player, last_login)
    if old_set_physics_override == nil then
        local pmt = getmetatable(player)
        old_set_physics_override = pmt.set_physics_override
        pmt.set_physics_override = new_set_physics_override
    end
end)