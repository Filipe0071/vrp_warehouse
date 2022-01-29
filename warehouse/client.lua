local inWarehouse, inMission = false, false
Citizen.CreateThread(function()
    local joinLoc, leaveLoc, computerLoc = vec3(-145.19108581543,-1429.9975585938,30.911861419678), vec3(1087.7553710938,-3099.4028320312,-38.999950408936), vec3(1088.3489990234,-3101.2429199219,-38.999961853027)
    local threads = 1000
    while true do
        local player = PlayerPedId()
        local playerCoords = GetEntityCoords(player)

        -- JOIN & LEAVE (WAREHOUSE)
        if joinLoc then
            local x,y,z = joinLoc.x, joinLoc.y, joinLoc.z
            if not inWarehouse then
                if #(vec3(x,y,z) - playerCoords) < 2.5 then
                    DrawText3D(x,y,z + 0.45, "~w~Warehouse ~g~Behind Shop", 0.75, 0)
                    if #(vec3(x,y,z) - playerCoords) < 0.5 then
                        DrawText3D(x,y,z + 0.30, "Apasa ~g~E ~w~pentru a intra in ~g~Warehouse", 0.65, 0)
                        DrawText3D(x,y,z + 0.15, "Proprietar: ~g~warfa", 0.65, 0)
                        if IsControlJustPressed(0, 51) then inWarehouse = true
                            SetEntityCoords(player, leaveLoc.x, leaveLoc.y, leaveLoc.z)
                        end
                    end
                    threads = 0
                else
                    threads = 500
                end
            end
        end

        if leaveLoc then
            local x,y,z = leaveLoc.x, leaveLoc.y, leaveLoc.z
            if inWarehouse then
                if #(vec3(x,y,z) - playerCoords) < 1 then
                    DrawText3D(x,y,z + 0.45, "~w~Warehouse ~g~Behind Shop", 0.75, 0)
                    if #(vec3(x,y,z) - playerCoords) < 0.5 then
                        DrawText3D(x,y,z + 0.30, "Apasa ~g~E ~w~pentru a iesi din ~g~Warehouse", 0.65, 0)
                        if IsControlJustPressed(0, 51) then inWarehouse = false
                            SetEntityCoords(player, joinLoc.x, joinLoc.y, joinLoc.z)
                        end
                    end
                else
                    threads = 500
                end
                threads = 0
            end
        end

        -- ACCES COMPUTER
        if computerLoc then
            local x,y,z = computerLoc.x, computerLoc.y, computerLoc.z
            if inWarehouse then
                if #(vec3(x,y,z) - playerCoords) < 1 then
                    DrawText3D(x,y,z + 0.45, "~w~Calculator de ~g~Misiuni", 0.75, 0)
                    if #(vec3(x,y,z) - playerCoords) < 0.5 then
                        DrawText3D(x,y,z + 0.30, "Apasa ~g~E ~w~pentru deschide ~g~Calculator", 0.65, 0)
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