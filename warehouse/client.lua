local inWarehouse, inMission = false, false
Citizen.CreateThread(function()
    local threads = 1000
    while true do
        local player = PlayerPedId()
        local playerCoords = GetEntityCoords(player)

        -- cam twisted codu asta, plm
        for i,v in pairs(config) do
            
            if not inWarehouse then
                local x,y,z = v.join[1], v.join[2], v.join[3]
                if #(vec3(x,y,z) - playerCoords) < 2.5 then
                    DrawText3D(x,y,z + 0.45, "~w~Warehouse ~g~"..v.name, 0.75, 0)
                    if #(vec3(x,y,z) - playerCoords) < 0.5 then
                        DrawText3D(x,y,z + 0.30, "Apasa ~g~E ~w~pentru a intra in ~g~Warehouse", 0.65, 0)
                        if IsControlJustPressed(0, 51) then inWarehouse = true
                            SetEntityCoords(player, v.leave[1], v.leave[2], v.leave[3])
                        end
                    end
                    threads = 0 
                else
                    threads = 500
                end
            end
            
            if inWarehouse then
                local x,y,z = v.leave[1], v.leave[2], v.leave[3]
                local x2,y2,z2 = v.computer[1], v.computer[2], v.computer[3]

                if #(vec3(x,y,z) - playerCoords) < 1 then
                    DrawText3D(x,y,z + 0.45, "~w~Warehouse ~g~"..v.name, 0.75, 0)
                    if #(vec3(x,y,z) - playerCoords) < 0.5 then
                        DrawText3D(x,y,z + 0.30, "Apasa ~g~E ~w~pentru a iesi din ~g~Warehouse", 0.65, 0)
                        if IsControlJustPressed(0, 51) then inWarehouse = false
                            SetEntityCoords(player, v.join[1], v.join[2], v.join[3])
                        end
                    end
                else
                    threads = 500
                end

                if #(vec3(x2,y2,z2) - playerCoords) < 1 then
                    DrawText3D(x2,y2,z2 + 0.45, "~w~Laptop ~g~"..v.name, 0.75, 0)
                    if #(vec3(x2,y2,z2) - playerCoords) < 0.5 then
                        DrawText3D(x2,y2,z2 + 0.30, "Apasa ~g~E ~w~a deschide Laptop ~g~"..v.name, 0.65, 0)
                        if IsControlJustPressed(0, 51) then
                            TriggerServerEvent("warehouse:openMenu", inWarehouse)
                        end
                    end
                else
                    threads = 500
                end

                threads = 0
            end

        end

        Citizen.Wait(threads)
    end
end)

RegisterNetEvent("warehouse:firstMission")
AddEventHandler("warehouse:firstMission", function()
    local player = PlayerPedId()
    -- to be continued
end)

function DrawText3D(x,y,z, text, scl, font) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(font)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end
