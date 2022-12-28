ESX = nil

Citizen.CreateThread(function()
    ESX = exports["es_extended"]:getSharedObject()
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local playerCoords = GetEntityCoords(PlayerPedId(), true)

        -- import enter check
        if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 1025.393433, -2398.905518, 29.903320, true) <= 3.0 then
            ESX.ShowHelpNotification(_U('press_to_enter'))
            if IsControlPressed(0, 51) then
                DoScreenFadeOut(1000)
                Citizen.Wait(1500)

                SetEntityCoords(PlayerPedId(), 1022.123108, -2398.377930, 30.122314) 

                Citizen.Wait(1000)
                DoScreenFadeIn(1000)
            end
        end

        -- import exit
        if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 1022.123108, -2398.377930, 30.122314, true) <= 3.0 then
            ESX.ShowHelpNotification(_U('press_to_exit'))
            if IsControlPressed(0, 51) then
                DoScreenFadeOut(1000)
                Citizen.Wait(1500)

                SetEntityCoords(PlayerPedId(), 1025.459351, -2398.865967, 29.903320, 239.736) 

                Citizen.Wait(1000)
                DoScreenFadeIn(1000)
            end
        end
    end
end)



function addBlip(blipX, blipY, blipZ, blipName, blipSprite)
    local blip = AddBlipForCoord(blipX, blipY, blipZ)
    SetBlipSprite(blip, blipSprite)
    SetBlipScale(blip, 1.0)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(blipName)
    EndTextCommandSetBlipName(blip)
end
