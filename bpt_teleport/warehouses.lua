ESX = nil
CreateThread(function()
    ESX = exports["es_extended"]:getSharedObject()
end)

CreateThread(function()
    while true do
        Wait(0)
        local playerCoords = GetEntityCoords(PlayerPedId(), true)
        -- import enter check
        if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 1025.393433, -2398.905518, 29.903320, true) <= 3.0 then
            ESX.ShowHelpNotification(_U('press_to_enter'))
            if IsControlPressed(0, 51) then
                DoScreenFadeOut(1000)
                Wait(1500)
                SetEntityCoords(PlayerPedId(), 1022.123108, -2398.377930, 30.122314) 
                Wait(1000)
                DoScreenFadeIn(1000)
            end
        end
        -- import exit
        if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 1022.123108, -2398.377930, 30.122314, true) <= 3.0 then
            ESX.ShowHelpNotification(_U('press_to_exit'))
            if IsControlPressed(0, 51) then
                DoScreenFadeOut(1000)
                Wait(1500)
                SetEntityCoords(PlayerPedId(), 1025.459351, -2398.865967, 29.903320, 239.736) 
                Wait(1000)
                DoScreenFadeIn(1000)
            end
        end
    end
end)

-- Unicorn
CreateThread(function()
    while true do
        Wait(0)
        local playerCoords = GetEntityCoords(PlayerPedId(), true)
        if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 132.608, -1293.978, 28.269, true) <= 3.0 then
            ESX.ShowHelpNotification(_U('press_to_enter'))
            if IsControlPressed(0, 51) then
                DoScreenFadeOut(1000)
                Wait(1500)
                SetEntityCoords(PlayerPedId(), 126.742, -1278.386, 28.569) 
                Wait(1000)
                DoScreenFadeIn(1000)
            end
        end
        -- import exit
        if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 132.540665, -1290.329712, 29.263062, true) <= 3.0 then
            ESX.ShowHelpNotification(_U('press_to_exit'))
            if IsControlPressed(0, 51) then
                DoScreenFadeOut(1000)
                Wait(1500)
                SetEntityCoords(PlayerPedId(), 132.527481, -1294.153809, 29.263062) 
                Wait(1000)
                DoScreenFadeIn(1000)
            end
        end
    end
end)
