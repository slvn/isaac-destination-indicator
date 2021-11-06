
local ____modules = {}
local ____moduleCache = {}
local ____originalRequire = require
local function require(file)
    if ____moduleCache[file] then
        return ____moduleCache[file]
    end
    if ____modules[file] then
        ____moduleCache[file] = ____modules[file]()
        return ____moduleCache[file]
    else
        if ____originalRequire then
            return ____originalRequire(file)
        else
            error("module '" .. file .. "' not found")
        end
    end
end
____modules = {
["main"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
function getOffset(self)
    if ScreenHelper ~= nil then
        return ScreenHelper:GetOffset()
    end
    return 0
end
function characterYOffset(self)
    local ____switch23 = Game():GetPlayer(0):GetPlayerType()
    if ____switch23 == PlayerType.PLAYER_JACOB then
        goto ____switch23_case_0
    elseif ____switch23 == PlayerType.PLAYER_BETHANY then
        goto ____switch23_case_1
    elseif ____switch23 == PlayerType.PLAYER_BETHANY_B then
        goto ____switch23_case_2
    end
    goto ____switch23_case_default
    ::____switch23_case_0::
    do
        return 13
    end
    ::____switch23_case_1::
    do
    end
    ::____switch23_case_2::
    do
        return 8
    end
    ::____switch23_case_default::
    do
        return 0
    end
    ::____switch23_end::
end
mod = RegisterMod("isaacDestinationIndicator", 1)
SPRITE_MOM_FOOT = 0
SPRITE_MOM_HEART = 1
SPRITE_SATAN = 2
SPRITE_ISAAC = 3
SPRITE_THE_LAMB = 4
SPRITE_BLUE_BABY = 5
SPRITE_MEGA_SATAN = 6
SPRITE_HUSH = 8
SPRITE_DELIRIUM = 9
SPRITE_MOTHER = 10
SPRITE_THE_BEAST = 11
SPRITE_EMPTY = 12
RANDOM = {SPRITE_MOM_FOOT, SPRITE_MOM_HEART, SPRITE_SATAN, SPRITE_ISAAC, SPRITE_THE_LAMB, SPRITE_BLUE_BABY, SPRITE_MEGA_SATAN, SPRITE_HUSH, SPRITE_DELIRIUM, SPRITE_MOTHER, SPRITE_THE_BEAST}
sprite = Sprite()
base = Vector(20, 73)
hudOffset = 0
destination = SPRITE_EMPTY
function postGameStarted(self)
    sprite:Load("gfx/ui/hudpickups2.anm2", true)
    local seed = Game():GetSeeds():GetStartSeed()
    Isaac.DebugString(
        "isaac-destination-indicator using seed: " .. tostring(seed)
    )
    math.randomseed(seed)
end
function inputAction(self, _entity, _hook, _buttonAction)
    if Input.IsButtonPressed(Keyboard.KEY_LEFT_SHIFT, 0) or Input.IsButtonPressed(Keyboard.KEY_RIGHT_SHIFT, 0) then
        if Game():IsPaused() then
            return nil
        end
        if Input.IsButtonTriggered(Keyboard.KEY_1, 0) then
            destination = SPRITE_BLUE_BABY
        elseif Input.IsButtonTriggered(Keyboard.KEY_2, 0) then
            destination = SPRITE_THE_LAMB
        elseif Input.IsButtonTriggered(Keyboard.KEY_3, 0) then
            destination = SPRITE_MOTHER
        elseif Input.IsButtonTriggered(Keyboard.KEY_4, 0) then
            destination = SPRITE_THE_BEAST
        elseif Input.IsButtonTriggered(Keyboard.KEY_5, 0) then
            destination = SPRITE_MEGA_SATAN
        elseif Input.IsButtonTriggered(Keyboard.KEY_6, 0) then
            destination = SPRITE_HUSH
        elseif Input.IsButtonTriggered(Keyboard.KEY_7, 0) then
            destination = SPRITE_DELIRIUM
        elseif Input.IsButtonTriggered(Keyboard.KEY_8, 0) then
            destination = SPRITE_SATAN
        elseif Input.IsButtonTriggered(Keyboard.KEY_9, 0) then
            destination = SPRITE_ISAAC
        elseif Input.IsButtonTriggered(Keyboard.KEY_0, 0) then
            destination = SPRITE_EMPTY
        elseif Input.IsButtonTriggered(Keyboard.KEY_GRAVE_ACCENT, 0) then
            destination = RANDOM[(Random() % #RANDOM) + 1]
        elseif Input.IsButtonTriggered(Keyboard.KEY_BACKSPACE, 0) then
            destination = RANDOM[(Random() % #RANDOM) + 1]
        else
            return nil
        end
        sprite:SetFrame("Destination", destination)
        return false
    end
    return nil
end
function postRender(self)
    local offset = getOffset(nil)
    local x = base.X + (2 * offset)
    local y = (base.Y + (1.2 * offset)) + characterYOffset(nil)
    sprite:Render(
        Vector(x, y),
        Vector(0, 0),
        Vector(0, 0)
    )
end
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, postGameStarted)
mod:AddCallback(ModCallbacks.MC_POST_RENDER, postRender)
mod:AddCallback(ModCallbacks.MC_INPUT_ACTION, inputAction, InputHook.IS_ACTION_PRESSED)
Isaac.DebugString("isaac-destination-indicator initialized.")
end,
}
return require("main")
