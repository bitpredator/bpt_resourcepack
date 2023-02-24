local damageMultip = 6.0 -- Damage default kat sayısı
local particleDict = "scr_gr_def" -- Particle dictionary
local particleName = "scr_gr_sw_engine_smoke" -- Particle name
local boneName = "engine" -- Motor bölgesi
local firstThreshold = 650.0 -- Motorun az tütmeye başlayacağı ilk eşik değeri
local secondThreshold = 350.0 -- Motorun çok tütmeye başlayacağı ikinci eşik değeri
local firstDelay = 20000 -- Motor az tütmeye başlayınca 20 saniyede bir motor açılıp kapanması için gereken süre, 20 saniyede bir motor kapanıp açılacak
local secondDelay = 10000 -- Motor çok tütmeye başlayınca 10 saniyede bir motor açılıp kapanması için gereken süre, 10 saniyede bir motor kapanıp açılacak
local isStarted = false
local fxIds = {}

Citizen.CreateThread(function()
 	while true do
 		Citizen.Wait(0)
		if IsPedInAnyVehicle(PlayerPedId(), false) then
			local veh = GetVehiclePedIsUsing(PlayerPedId())
			local armourIndex = GetVehicleMod(veh, 16)
			if armourIndex == 4 then -- %100
				local damage = damageMultip
				RequestNamedPtfxAsset(particleDict)
				while not HasNamedPtfxAssetLoaded(particleDict) do
					Citizen.Wait(0)
				end
				UseParticleFxAssetNextCall(particleDict)
				if armourIndex == 0 then
					damage = damageMultip - 2.0
				elseif armourIndex == -1 then
					damage = damageMultip
				else
					damage = damageMultip - ((damageMultip * armourIndex) / 10)
				end
				SetVehicleDamageModifier(veh, damage)

				if GetVehicleEngineHealth(veh) <= firstThreshold and not isStarted then
					fxId = StartParticleFxLoopedOnEntityBone(particleName, veh, 0, 0, 1, 0, 0, 0, GetEntityBoneIndexByName(veh, boneName), 0.25, 0, 0, 3.0)
					isStarted = true
					table.insert(fxIds, fxId)
				end
				if GetVehicleEngineHealth(veh) <= secondThreshold and isStarted and #fxIds == 1 then
					fxId = StartParticleFxLoopedOnEntityBone(particleName, veh, 0, 0, 1, 0, 0, 0, GetEntityBoneIndexByName(veh, boneName), 0.90, 0, 0, 3.0)
					table.insert(fxIds, fxId)
				end
				if GetVehicleEngineHealth(veh) >= firstThreshold and isStarted and #fxIds == 2 then
					isStarted = false
					for i = 1, #fxIds do
						StopParticleFxLooped(fxIds[i], 0)
					end
					fxIds = {}
				end
			elseif armourIndex == 3 then -- %80
				local damage = damageMultip
				RequestNamedPtfxAsset(particleDict)
				while not HasNamedPtfxAssetLoaded(particleDict) do
					Citizen.Wait(0)
				end
				UseParticleFxAssetNextCall(particleDict)
				if armourIndex == 0 then
					damage = damageMultip - 2.0
				elseif armourIndex == -1 then
					damage = damageMultip
				else
					damage = damageMultip - ((damageMultip * armourIndex) / 10)
				end
				SetVehicleDamageModifier(veh, damage)

				if GetVehicleEngineHealth(veh) <= firstThreshold and not isStarted then
					fxId = StartParticleFxLoopedOnEntityBone(particleName, veh, 0, 0, 1, 0, 0, 0, GetEntityBoneIndexByName(veh, boneName), 0.25, 0, 0, 3.0)
					isStarted = true
					table.insert(fxIds, fxId)
				end
				if GetVehicleEngineHealth(veh) <= secondThreshold and isStarted and #fxIds == 1 then
					fxId = StartParticleFxLoopedOnEntityBone(particleName, veh, 0, 0, 1, 0, 0, 0, GetEntityBoneIndexByName(veh, boneName), 0.90, 0, 0, 3.0)
					table.insert(fxIds, fxId)
				end
				if GetVehicleEngineHealth(veh) >= firstThreshold and isStarted and #fxIds == 2 then
					isStarted = false
					for i = 1, #fxIds do
						StopParticleFxLooped(fxIds[i], 0)
					end
					fxIds = {}
				end
			elseif armourIndex == 2 then -- %60
				local damage = damageMultip
				RequestNamedPtfxAsset(particleDict)
				while not HasNamedPtfxAssetLoaded(particleDict) do
					Citizen.Wait(0)
				end
				UseParticleFxAssetNextCall(particleDict)
				if armourIndex == 0 then
					damage = damageMultip - 2.0
				elseif armourIndex == -1 then
					damage = damageMultip
				else
					damage = damageMultip - ((damageMultip * armourIndex) / 10)
				end
				SetVehicleDamageModifier(veh, damage)

				if GetVehicleEngineHealth(veh) <= firstThreshold and not isStarted then
					fxId = StartParticleFxLoopedOnEntityBone(particleName, veh, 0, 0, 1, 0, 0, 0, GetEntityBoneIndexByName(veh, boneName), 0.25, 0, 0, 3.0)
					isStarted = true
					table.insert(fxIds, fxId)
				end
				if GetVehicleEngineHealth(veh) <= secondThreshold and isStarted and #fxIds == 1 then
					fxId = StartParticleFxLoopedOnEntityBone(particleName, veh, 0, 0, 1, 0, 0, 0, GetEntityBoneIndexByName(veh, boneName), 0.90, 0, 0, 3.0)
					table.insert(fxIds, fxId)
				end
				if GetVehicleEngineHealth(veh) >= firstThreshold and isStarted and #fxIds == 2 then
					isStarted = false
					for i = 1, #fxIds do
						StopParticleFxLooped(fxIds[i], 0)
					end
					fxIds = {}
				end
			elseif armourIndex == 1 then -- %40
				local damage = damageMultip
				RequestNamedPtfxAsset(particleDict)
				while not HasNamedPtfxAssetLoaded(particleDict) do
					Citizen.Wait(0)
				end
				UseParticleFxAssetNextCall(particleDict)
				if armourIndex == 0 then
					damage = damageMultip - 2.0
				elseif armourIndex == -1 then
					damage = damageMultip
				else
					damage = damageMultip - ((damageMultip * armourIndex) / 10)
				end
				SetVehicleDamageModifier(veh, damage)

				if GetVehicleEngineHealth(veh) <= firstThreshold and not isStarted then
					fxId = StartParticleFxLoopedOnEntityBone(particleName, veh, 0, 0, 1, 0, 0, 0, GetEntityBoneIndexByName(veh, boneName), 0.25, 0, 0, 3.0)
					isStarted = true
					table.insert(fxIds, fxId)
				end
				if GetVehicleEngineHealth(veh) <= secondThreshold and isStarted and #fxIds == 1 then
					fxId = StartParticleFxLoopedOnEntityBone(particleName, veh, 0, 0, 1, 0, 0, 0, GetEntityBoneIndexByName(veh, boneName), 0.90, 0, 0, 3.0)
					table.insert(fxIds, fxId)
				end
				if GetVehicleEngineHealth(veh) >= firstThreshold and isStarted and #fxIds == 2 then
					isStarted = false
					for i = 1, #fxIds do
						StopParticleFxLooped(fxIds[i], 0)
					end
					fxIds = {}
				end
			elseif armourIndex == 0 then -- %20
				local damage = damageMultip
				RequestNamedPtfxAsset(particleDict)
				while not HasNamedPtfxAssetLoaded(particleDict) do
					Citizen.Wait(0)
				end
				UseParticleFxAssetNextCall(particleDict)
				if armourIndex == 0 then
					damage = damageMultip - 2.0
				elseif armourIndex == -1 then
					damage = damageMultip
				else
					damage = damageMultip - ((damageMultip * armourIndex) / 10)
				end
				SetVehicleDamageModifier(veh, damage)

				if GetVehicleEngineHealth(veh) <= firstThreshold and not isStarted then
					fxId = StartParticleFxLoopedOnEntityBone(particleName, veh, 0, 0, 1, 0, 0, 0, GetEntityBoneIndexByName(veh, boneName), 0.25, 0, 0, 3.0)
					isStarted = true
					table.insert(fxIds, fxId)
				end
				if GetVehicleEngineHealth(veh) <= secondThreshold and isStarted and #fxIds == 1 then
					fxId = StartParticleFxLoopedOnEntityBone(particleName, veh, 0, 0, 1, 0, 0, 0, GetEntityBoneIndexByName(veh, boneName), 0.90, 0, 0, 3.0)
					table.insert(fxIds, fxId)
				end
				if GetVehicleEngineHealth(veh) >= firstThreshold and isStarted and #fxIds == 2 then
					isStarted = false
					for i = 1, #fxIds do
						StopParticleFxLooped(fxIds[i], 0)
					end
					fxIds = {}
				end
			elseif armourIndex == -1 then -- No Armour
				local damage = damageMultip
				RequestNamedPtfxAsset(particleDict)
				while not HasNamedPtfxAssetLoaded(particleDict) do
					Citizen.Wait(0)
				end
				UseParticleFxAssetNextCall(particleDict)
				if armourIndex == 0 then
					damage = damageMultip - 2.0
				elseif armourIndex == -1 then
					damage = damageMultip
				else
					damage = damageMultip - ((damageMultip * armourIndex) / 10)
				end
				SetVehicleDamageModifier(veh, damage)

				if GetVehicleEngineHealth(veh) <= firstThreshold and not isStarted then
					fxId = StartParticleFxLoopedOnEntityBone(particleName, veh, 0, 0, 1, 0, 0, 0, GetEntityBoneIndexByName(veh, boneName), 0.25, 0, 0, 3.0)
					isStarted = true
					table.insert(fxIds, fxId)
				end
				if GetVehicleEngineHealth(veh) <= secondThreshold and isStarted and #fxIds == 1 then
					fxId = StartParticleFxLoopedOnEntityBone(particleName, veh, 0, 0, 1, 0, 0, 0, GetEntityBoneIndexByName(veh, boneName), 0.90, 0, 0, 3.0)
					table.insert(fxIds, fxId)
				end
				if GetVehicleEngineHealth(veh) >= firstThreshold and isStarted and #fxIds == 2 then
					isStarted = false
					for i = 1, #fxIds do
						StopParticleFxLooped(fxIds[i], 0)
					end
					fxIds = {}
				end
			end
		end
 	end
 end)


 
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if #fxIds == 1 then
			if IsPedInAnyVehicle(PlayerPedId(), false) then
				local veh = GetVehiclePedIsUsing(PlayerPedId())
				Citizen.Wait(firstDelay)
				SetVehicleEngineOn(veh, false, true, false)
				Citizen.Wait(firstDelay)
				SetVehicleEngineOn(veh, true, true, false)
			end
		elseif #fxIds == 2 then
			if IsPedInAnyVehicle(PlayerPedId(), false) then
				local veh = GetVehiclePedIsUsing(PlayerPedId())
				SetVehicleEngineCanDegrade(veh, 1)
				Citizen.Wait(secondDelay)
				SetVehicleEngineOn(veh, false, false, false)
				Citizen.Wait(secondDelay)
				SetVehicleEngineOn(veh, true, false, false)
			end
		end
	end
end)