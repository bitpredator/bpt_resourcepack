local lastPlayerSuccess = {}

if Config.MaxInService ~= -1 then
    TriggerEvent('esx_service:activateService', 'import', Config.MaxInService)
end

TriggerEvent('esx_society:registerSociety', 'import', 'Import', 'society_import', 'society_import', 'society_import', {
    type = 'public'
})

ESX.RegisterServerCallback("bpt_importjob:SpawnVehicle", function(source, cb, model , props)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "import" then 
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
