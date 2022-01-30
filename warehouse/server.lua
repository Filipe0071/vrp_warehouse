local Tunnel <const> = module("lib/Tunnel")
local Proxy <const> = module("lib/Proxy")

local vRP <const> = Proxy.getInterface("vRP")
local vRPclient <const> = Tunnel.getInterface("vRP", "warehouse")

--[[ SQL
CREATE TABLE `vrp_warehouse` (
  `warehouse` int(11) NOT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;  

ALTER TABLE `vrp_warehouse`
  ADD PRIMARY KEY (`warehouse`);
COMMIT;
]]--

RegisterNetEvent("warehouse:checkWarehouse")
AddEventHandler("warehouse:checkWarehouse", function(warehouse)
    local player = source
    local user_id = vRP.getUserId({player})
    if user_id ~= nil then 
        local rows = exports.ghmattimysql:executeSync("SELECT id FROM vrp_warehouse WHERE warehouse = @warehouse", {["@warehouse"] = warehouse})[1]
        if rows then
            if tonumber(rows.id) == user_id then
                print(user_id)
            else
                vRPclient.notify(player,{"~r~Acest warehouse este deja luat!"})
            end
        else
            for i,v in pairs(config) do
                local checkMoney = vRP.getMoney({user_id})
                if checkMoney > tonumber(v.priceWarehouse) then
                    exports.ghmattimysql:execute("INSERT INTO vrp_warehouse (warehouse, id) VALUES (@warehouse, @id)", {["@warehouse"] = warehouse, ["@id"] = user_id})
                    print("cu succes")
                else
                    print("n-ai bani fmm")
                end
            end
        end
    end
end)
