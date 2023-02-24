local HasAlreadyEnteredMarker, CurrentAction,
    CurrentActionData = false, false, false, false, false, {}
local LastZone, CurrentActionMsg

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

function OpenCloakroom()
    local elements = {
        {unselectable = true, icon = "fas fa-shirt", title = _U('cloakroom_menu')},
        {icon = "fas fa-shirt", title = _U('wear_citizen'), value = "wear_citizen"},
        {icon = "fas fa-shirt", title = _U('wear_work'), value = "wear_work"},
    }

    ESX.OpenContext("right", elements, function(menu,element)
        if element.value == "wear_citizen" then
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadSkin', skin)
            end)
        elseif element.value == "wear_work" then
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                if skin.sex == 0 then
                    TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
                else
                    TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
                end
            end)
        end
		ESX.CloseContext()
    end, function(menu)
        CurrentAction = 'cloakroom'
        CurrentActionMsg = _U('cloakroom_prompt')
        CurrentActionData = {}
    end)
end

function OpenVehicleSpawnerMenu()
    local elements = {
        {unselectable = true, icon = "fas fa-car", title = _U('spawn_veh')}
    }

    if Config.EnableSocietyOwnedVehicles then
        ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(vehicles)

			if #vehicles == 0 then
				ESX.ShowNotification(_U('empty_garage'))
				return
			end

            for i = 1, #vehicles, 1 do
                elements[#elements+1] = {
                    icon = "fas fa-car",
                    title = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. vehicles[i].plate .. ']',
                    value = vehicles[i]
                }
            end

            ESX.OpenContext("right", elements, function(menu,element)
                if not ESX.Game.IsSpawnPointClear(Config.Zones.VehicleSpawnPoint.Pos, 5.0) then
                    ESX.ShowNotification(_U('spawnpoint_blocked'))
                    return
                end

				if element.value == nil then
					print("ERROR: Context menu clicked item value is nil!")
					return
				end

                local vehicleProps = element.value
                ESX.TriggerServerCallback("bpt_bakerjob:SpawnVehicle", function()
                    return
                end, vehicleProps.model, vehicleProps)
                TriggerServerEvent('esx_society:removeVehicleFromGarage', 'baker', vehicleProps)
            end, function(menu)
                CurrentAction = 'vehicle_spawner'
                CurrentActionMsg = _U('spawner_prompt')
                CurrentActionData = {}
            end)
        end, 'baker')
    else -- not society vehicles

		if #Config.AuthorizedVehicles == 0 then
			ESX.ShowNotification(_U('empty_garage'))
			return
		end

		for i = 1, #Config.AuthorizedVehicles, 1 do
			elements[#elements+1] = {
				icon = "fas fa-car",
				title = Config.AuthorizedVehicles[i].label,
				value = Config.AuthorizedVehicles[i].model
			}
		end

        ESX.OpenContext("right", elements, function(menu,element)
            if not ESX.Game.IsSpawnPointClear(Config.Zones.VehicleSpawnPoint.Pos, 5.0) then
                ESX.ShowNotification(_U('spawnpoint_blocked'))
                return
            end

			if element.value == nil then
				print("ERROR: Context menu clicked item value is nil!")
				return
			end

            ESX.TriggerServerCallback("bpt_bakerjob:SpawnVehicle", function()
                ESX.ShowNotification(_U('vehicle_spawned'), "success")
            end, element.value, {plate = "BAKE JOB"})
			ESX.CloseContext()
        end, function(menu)
            CurrentAction = 'vehicle_spawner'
            CurrentActionMsg = _U('spawner_prompt')
            CurrentActionData = {}
        end)
    end
end

function DeleteJobVehicle()
    if Config.EnableSocietyOwnedVehicles then
        local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
        TriggerServerEvent('esx_society:putVehicleInGarage', 'baker', vehicleProps)
        ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
    else
        if IsInAuthorizedVehicle() then
            ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
        else
            ESX.ShowNotification(_U('only_baker'))
        end
    end
end

function OpenbakerActionsMenu()
    local elements = {
        {unselectable = true, icon = "fas fa-baker", title = _U('baker')}
    }

    if Config.EnablePlayerManagement and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        elements[#elements+1] = {
            icon = "fas fa-wallet",
            title = _U('boss_actions'),
            value = "boss_actions"
        }
    end

    ESX.OpenContext("right", elements, function(menu,element)
        if element.value == 'boss_actions' then
            TriggerEvent('esx_society:openBossMenu', 'baker', function(data, menu)
                menu.close()
            end)
        end
    end, function(menu)
        CurrentAction = 'baker_actions_menu'
        CurrentActionMsg = _U('press_to_open')
        CurrentActionData = {}
    end)
end

function OpenMobileBakerActionsMenu()
    local elements = {
        {unselectable = true, icon = "fas fa-baker", title = _U('baker')},
        {icon = "fas fa-scroll", title = _U('billing'), value = "billing"}
    }

    ESX.OpenContext("right", elements, function(menu,element)
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
                        TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_baker',
                            'Baker', amount)
                        ESX.ShowNotification(_U('billing_sent'))
                    end
                end
            end, function(data, menu)
                menu.close()
            end)
        end
    end)
end

function IsInAuthorizedVehicle()
    local playerPed = PlayerPedId()
    local vehModel = GetEntityModel(GetVehiclePedIsIn(playerPed, false))

    for i = 1, #Config.AuthorizedVehicles, 1 do
        if vehModel == joaat(Config.AuthorizedVehicles[i].model) then
            return true
        end
    end
    
    return false
end

AddEventHandler('bpt_bakerjob:hasEnteredMarker', function(zone)
    if zone == 'VehicleSpawner' then
        CurrentAction = 'vehicle_spawner'
        CurrentActionMsg = _U('spawner_prompt')
        CurrentActionData = {}
    elseif zone == 'VehicleDeleter' then
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        if IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(vehicle, -1) == playerPed then
            CurrentAction = 'delete_vehicle'
            CurrentActionMsg = _U('store_veh')
            CurrentActionData = {
                vehicle = vehicle
            }
        end
    elseif zone == 'BakerActions' then
        CurrentAction = 'baker_actions_menu'
        CurrentActionMsg = _U('press_to_open')
        CurrentActionData = {}

    elseif zone == 'Cloakroom' then
        CurrentAction = 'cloakroom'
        CurrentActionMsg = _U('cloakroom_prompt')
        CurrentActionData = {}
    end
end)

AddEventHandler('bpt_bakerjob:hasExitedMarker', function(zone)
    ESX.CloseContext()
    CurrentAction = nil
end)

-- Create Blips
CreateThread(function()
    local blip = AddBlipForCoord(Config.Zones.BakerActions.Pos.x, Config.Zones.BakerActions.Pos.y,
        Config.Zones.BakerActions.Pos.z)

    SetBlipSprite(blip, 156)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 1.0)
    SetBlipColour(blip, 5)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(_U('blip_baker'))
    EndTextCommandSetBlipName(blip)
end)

-- Enter / Exit marker events, and draw markers
CreateThread(function()
    while true do
        local sleep = 1500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'baker' then

            local coords = GetEntityCoords(PlayerPedId())
            local isInMarker, currentZone = false
			local inVeh = IsPedInAnyVehicle(PlayerPedId())

            for k, v in pairs(Config.Zones) do
                local zonePos = vector3(v.Pos.x, v.Pos.y, v.Pos.z)
                local distance = #(coords - zonePos)

                if v.Type ~= -1 and distance < Config.DrawDistance then
                    sleep = 0
					if k == "VehicleDeleter" then
						if inVeh then
							DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y,
								v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, false, 2, v.Rotate, nil, nil, false)
						end
					else
						DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y,
							v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, false, 2, v.Rotate, nil, nil, false)
					end

                end

                if distance < v.Size.x then
                    isInMarker, currentZone = true, k
                end
            end

            if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
                HasAlreadyEnteredMarker, LastZone = true, currentZone
                TriggerEvent('bpt_bakerjob:hasEnteredMarker', currentZone)
            end

            if not isInMarker and HasAlreadyEnteredMarker then
                HasAlreadyEnteredMarker = false
                TriggerEvent('bpt_bakerjob:hasExitedMarker', LastZone)
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

            if IsControlJustReleased(0, 38) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'baker' then
                if CurrentAction == 'baker_actions_menu' then
                    OpenbakerActionsMenu()
                elseif CurrentAction == 'cloakroom' then
                    OpenCloakroom()
                elseif CurrentAction == 'vehicle_spawner' then
                    OpenVehicleSpawnerMenu()
                elseif CurrentAction == 'delete_vehicle' then
                    DeleteJobVehicle()
                end

                CurrentAction = nil
            end
        end
        Wait(sleep)
    end
end)

RegisterCommand('bakermenu', function()
    if not ESX.PlayerData.dead and Config.EnablePlayerManagement and ESX.PlayerData.job and ESX.PlayerData.job.name ==
        'baker' then
        OpenMobileBakerActionsMenu()
    end
end, false)

RegisterKeyMapping('bakermenu', 'Open Baker Menu', 'keyboard', 'f6')