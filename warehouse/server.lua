local Tunnel <const> = module("lib/Tunnel")
local Proxy <const> = module("lib/Proxy")

local vRP <const> = Proxy.getInterface("vRP")
local vRPclient <const> = Tunnel.getInterface("vRP", "warehouse")

local function openMenu(source)
    local player = source
    local user_id = vRP.getUserId({player})
    if user_id ~= nil then
        local menu = {}
        menu["#1 MISSION"] = {function(player, choice)
            TriggerClientEvent("warehouse:firstMission", player)
            vRPclient.notify(player,{"~r~Iesi din casa pentru a incepe Misiunea"})
            vRP.closeMenu({player})
        end, "andrei"}
        vRP.openMenu({player, menu})
    end
end

RegisterNetEvent("warehouse:openMenu")
AddEventHandler("warehouse:openMenu", function(inWarehouse)
    local player = source
    local user_id = vRP.getUserId({player})
    if user_id ~= nil then
        if inWarehouse then
            openMenu(player)          
        else
            vRPclient.notify(player,{"~r~Nu esti in warehouse!"})
        end
    else
        DropPlayer(player, "no id bro")
    end
end)