local HasAlreadyEnteredMarker
local CurrentAction, CurrentActionMsg = nil, {}
local LastZone

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
    ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
    ESX.PlayerLoaded = false
    ESX.PlayerData = {}
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

function DrawSub(msg, time)
    ClearPrints()
    BeginTextCommandPrint('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandPrint(time, 1)
end

function ShowLoadingPromt(msg, time, type)
    CreateThread(function()
        Wait(0)

        BeginTextCommandBusyspinnerOn('STRING')
        AddTextComponentSubstringPlayerName(msg)
        EndTextCommandBusyspinnerOn(type)
        Wait(time)

        BusyspinnerOff()
    end)
end

function OpenBallasActionsMenu()
    local elements = {
    }

    if Config.EnablePlayerManagement and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        elements[#elements+1] = {
            icon = "fas fa-wallet",
            title = _U('boss_actions'),
            value = "boss_actions"
        }
    end

    ESX.UI.Menu.CloseAll()

    ESX.OpenContext("right", elements, function(_,element)
        if element.value == 'boss_actions' then
            TriggerEvent('esx_society:openBossMenu', 'ballas', function(_, menu)
                menu.close()
            end)
        end

    end, function()
        CurrentAction = 'ballas_actions_menu'
        CurrentActionMsg = _U('press_to_open')
    end)
end

function OpenMobileBallasActionsMenu()
    local elements = {
        {unselectable = true, icon = "fas fa-ballas", title = _U('ballas')},
        {icon = "fas fa-scroll", title = _U('billing'), value = "billing"}
    }

    ESX.OpenContext("right", elements, function(_,element)
        if element.value == "billing" then
            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
                title = _U('invoice_amount')
            }, function(data, menu)

                local amount = tonumber(data.value)
                if amount == nil then
                    ESX.ShowNotification(_U('amount_invalid'))
                else
                    menu.close()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer == -1 or closestDistance > 3.0 then
                        ESX.ShowNotification(_U('no_players_near'))
                    else
                        TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_ballas',
                            'Ballas', amount)
                        ESX.ShowNotification(_U('billing_sent'))
                    end
                end
            end, function(_, menu)
                menu.close()
            end)
        end
    end)
end

AddEventHandler('bpt_ballasjob:hasEnteredMarker', function(zone)
    if zone == 'BallasActions' then
        CurrentAction = 'ballas_actions_menu'
        CurrentActionMsg = _U('press_to_open')
    end
end)

AddEventHandler('bpt_ballasjob:hasExitedMarker', function()
    ESX.UI.Menu.CloseAll()
    CurrentAction = nil
end)

-- Create Blips
CreateThread(function()
    local blip = AddBlipForCoord(Config.Zones.BallasActions.Pos.x, Config.Zones.BallasActions.Pos.y,
        Config.Zones.BallasActions.Pos.z)

        SetBlipSprite(blip, 106)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 1.0)
        SetBlipColour(blip, 27)
        SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(_U('blip_ballas'))
    EndTextCommandSetBlipName(blip)
end)

-- Enter / Exit marker events, and draw markers
CreateThread(function()
    while true do
        local sleep = 1500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ballas' then

            local coords = GetEntityCoords(PlayerPedId())
            local isInMarker, currentZone = false

            for k, v in pairs(Config.Zones) do
                local zonePos = vector3(v.Pos.x, v.Pos.y, v.Pos.z)
                local distance = #(coords - zonePos)

                if v.Type ~= -1 and distance < Config.DrawDistance then
                    sleep = 0
                    DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y,
                        v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, false, 2, v.Rotate, nil, nil, false)
                end

                if distance < v.Size.x then
                    isInMarker, currentZone = true, k
                end
            end

            if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
                HasAlreadyEnteredMarker, LastZone = true, currentZone
                TriggerEvent('bpt_ballasjob:hasEnteredMarker', currentZone)
            end

            if not isInMarker and HasAlreadyEnteredMarker then
                HasAlreadyEnteredMarker = false
                TriggerEvent('bpt_ballasjob:hasExitedMarker', LastZone)
            end
        end
        Wait(sleep)
    end
end)

-- Key Controls
CreateThread(function()
    while true do
        local sleep = 1500
        if CurrentAction and not ESX.PlayerData.dead then
            sleep = 0
            ESX.ShowHelpNotification(CurrentActionMsg)

            if IsControlJustReleased(0, 38) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'ballas' then
                if CurrentAction == 'ballas_actions_menu' then
                    OpenBallasActionsMenu()
                end

                CurrentAction = nil
            end
        end
        Wait(sleep)
    end
end)

RegisterCommand('ballasmenu', function()
    if not ESX.PlayerData.dead and Config.EnablePlayerManagement and ESX.PlayerData.job and ESX.PlayerData.job.name ==
        'ballas' then
        OpenMobileBallasActionsMenu()
    end
end, false)

RegisterKeyMapping('ballasmenu', 'Open ballas Menu', 'keyboard', 'f6')
