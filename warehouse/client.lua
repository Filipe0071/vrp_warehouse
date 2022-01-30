Citizen.CreateThread(function()
    local threads = 1000
    while true do
        local player = PlayerPedId()
        local playerCoords = GetEntityCoords(player)

        for i,v in pairs(config) do
            local x,y,z = v.join[1], v.join[2], v.join[3]
            if #(vec3(x,y,z) - playerCoords) < 2.5 then
                DrawText3D(x,y,z + 0.45, "~w~Warehouse ~g~#"..i, 0.75, 0)
                if #(vec3(x,y,z) - playerCoords) < 1 then
                    DrawText3D(x,y,z + 0.30, "Apasa ~g~E ~w~pentru a intra in ~g~Warehouse", 0.65, 0)
                    DrawText3D(x,y,z + 0.20, "Proprietar: ~g~To be Continued", 0.65, 0)
                    if IsControlJustPressed(0, 51) then
                        TriggerServerEvent("warehouse:checkWarehouse", i)
                    end
                end
            else
                threads = 512
            end
            
            
            
            --TriggerServerEvent("warehouse:checkWarehouse", i)
            threads = 0
        end

        Citizen.Wait(threads)
    end
end)

RegisterCommand("andrei", function()
    TriggerServerEvent("warehouse:checkInfo")
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
