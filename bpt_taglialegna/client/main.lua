Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local menuOpen = false

Citizen.CreateThread(function()
	ESX = exports["es_extended"]:getSharedObject()

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if menuOpen then
			ESX.UI.Menu.CloseAll()
		end
	end
end)


local spawnedLegno = 0
local AlberoLegno = {}
local Raccolta, Lavorazione = false, false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.LegnoField.coords, true) < 50 then
			SpawnAlberoLegno()
			Citizen.Wait(500)
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.CircleZones.LegnoProcessing.coords, true) < 1 then
			if not Lavorazione then
				ESX.ShowHelpNotification(_U('wood_processprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not Lavorazione then

				if Config.LicenseEnable then
				else
					ProcessLegno()
				end

			end
		else
			Citizen.Wait(500)
		end
	end
end)

function LavorazioneAnimazione()
	local Animated = PlayerPedId()
	
	RequestAnimDict("timetable@floyd@clean_kitchen@base")
	Wait(1000)

	TaskPlayAnim(Animated, "timetable@floyd@clean_kitchen@base", "base", 10.0, 10.0, -1, 0, 0, false, false, false) 
end


function ProcessLegno()
	Lavorazione = true

	ESX.ShowNotification(_U('wood_processingstarted'))
	TriggerServerEvent('bpt_taglialegna:processLegno')
	local timeLeft = Config.Delays.LegnoProcessing / 1000
	local playerPed = PlayerPedId()

	LavorazioneAnimazione()
	Wait(950)
	while timeLeft > 0 do
		
		Citizen.Wait(1000)
		timeLeft = timeLeft - 1

		if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.LegnoProcessing.coords, false) > 4 then
			ESX.ShowNotification(_U('wood_processingtoofar'))
			TriggerServerEvent('bpt_taglialegna:cancelProcessing')
			break
		end
	end

	Lavorazione = false
end

function tagliaalbero()
	local jake = PlayerPedId()
	
	RequestAnimDict("melee@hatchet@streamed_core")
	Wait(1200)

	TaskPlayAnim(jake, "melee@hatchet@streamed_core", "plyr_front_takedown_b", 6.0, -6.0, -1, 0, 0, false, false, false) 
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local giocatore = PlayerPedId()
		local coords = GetEntityCoords(giocatore)
		local alberolegno, nearbyID
		
		for i=1, #AlberoLegno, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(AlberoLegno[i]), false) < 1 then
				alberolegno, nearbyID = AlberoLegno[i], i
			end
		end

		if alberolegno and IsPedOnFoot(giocatore) then

			if not Raccolta then
				ESX.ShowHelpNotification(_U('wood_pickupprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not Raccolta then
				Raccolta = true

				ESX.TriggerServerCallback('bpt_taglialegna:canPickUp', function(canPickUp)

					if canPickUp then
						GiveWeaponToPed(giocatore, "WEAPON_HATCHET", 800, false, false)
						SetCurrentPedWeapon(giocatore, GetHashKey("WEAPON_HATCHET"), false)
						tagliaalbero()
						Wait(3000)
						Citizen.Wait(400)
						ClearPedTasks(giocatore)
						Citizen.Wait(400)
						SetEntityRotation(alberolegno, 80.0, -0, 85.0, false, true)
						Citizen.Wait(200)
						DeleteObject(alberolegno)
						RemoveWeaponFromPed(giocatore, GetHashKey("WEAPON_HATCHET"), true, true)
						SetCurrentPedWeapon(giocatore, GetHashKey("WEAPON_UNARMED"), false)

						TriggerServerEvent('bpt_taglialegna:pickedUpLegno')
					else
						ESX.ShowNotification(_U('wood_inventoryfull'))
					end

					Raccolta = false

				end, 'legno')
			end

		else
			Citizen.Wait(500)
		end

	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(AlberoLegno) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnAlberoLegno()
	while spawnedLegno < 25 do
		Citizen.Wait(0)
		local legnoCoords = GenerateLegnoCoords()

		ESX.Game.SpawnLocalObject('prop_tree_eng_oak_cr2', legnoCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(AlberoLegno, obj)
			spawnedLegno = spawnedLegno + 1
		end)
	end
end

function ValidateLegnoCoord(plantCoord)
	if spawnedLegno > 0 then
		local validate = true

		for k, v in pairs(AlberoLegno) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.LegnoField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateLegnoCoords()
	while true do
		Citizen.Wait(1)

		local legnoCoordX, legnoCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-90, 90)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-90, 90)

		legnoCoordX = Config.CircleZones.LegnoField.coords.x + modX
		legnoCoordY = Config.CircleZones.LegnoField.coords.y + modY

		local coordZ = GetCoordZ(legnoCoordX, legnoCoordY)
		local coord = vector3(legnoCoordX, legnoCoordY, coordZ)

		if ValidateLegnoCoord(coord) then
			return coord
		end
	end
end

function GetCoordZ(x, y)
	local groundCheckHeights = { 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0, 49.0, 50.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 43.0
end

function CreateBlipCircle(coords, text, radius, color, sprite)
	local blip = AddBlipForRadius(coords, radius)

	SetBlipHighDetail(blip, true)
	SetBlipColour(blip, 1)
	SetBlipAlpha (blip, 128)

	-- create a blip in the middle
	blip = AddBlipForCoord(coords)

	SetBlipHighDetail(blip, true)
	SetBlipSprite (blip, sprite)
	SetBlipScale  (blip, 1.0)
	SetBlipColour (blip, color)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(text)
	EndTextCommandSetBlipName(blip)
end

Citizen.CreateThread(function()
	for k,zone in pairs(Config.CircleZones) do

		CreateBlipCircle(zone.coords, zone.name, zone.radius, zone.color, zone.sprite)
	end
end)