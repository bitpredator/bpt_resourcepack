TriggerEvent('esx_society:registerSociety', 'dustman', 'Dustman', 'society_dustman', 'society_dustman', 'society_dustman', {
    type = 'public'
})

if Config.MaxInService ~= -1 then
    TriggerEvent('esx_service:activateService', 'dustman', Config.MaxInService)
end

ESX.RegisterServerCallback("bpt_dustmanjob:SpawnVehicle", function(source, cb, model , props)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "dustman" then 
        print(('[^3WARNING^7] Player ^5%s^7 attempted to Exploit Vehicle Spawing!!'):format(source))
        return
    end
    local SpawnPoint = vector3(Config.Zones.VehicleSpawnPoint.Pos.x, Config.Zones.VehicleSpawnPoint.Pos.y, Config.Zones.VehicleSpawnPoint.Pos.z)
    ESX.OneSync.SpawnVehicle(joaat(model), SpawnPoint, Config.Zones.VehicleSpawnPoint.Heading, props, function(vehicle)
        local vehicle = NetworkGetEntityFromNetworkId(vehicle)
        while GetVehicleNumberPlateText(vehicle) ~= props.plate do
            Wait(0)
        end
        TaskWarpPedIntoVehicle(GetPlayerPed(source), vehicle, -1)
    end)
    cb()
end)

ESX.RegisterServerCallback('bpt_dustmanjob:getPlayerInventory', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local items = xPlayer.inventory

    local minItems = xPlayer.getInventory(true)
	cb(next(minItems) ~= nil and items or false)
end)