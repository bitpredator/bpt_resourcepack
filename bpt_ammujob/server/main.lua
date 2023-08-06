TriggerEvent('esx_society:registerSociety', 'ammu', 'Ammu', 'society_ammu', 'society_ammu', 'society_ammu', {
    type = 'public'
})

if Config.MaxInService ~= -1 then
    TriggerEvent('esx_service:activateService', 'ammu', Config.MaxInService)
end

ESX.RegisterServerCallback("bpt_ammujob:SpawnVehicle", function(source, cb, model , props)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "ammu" then
        print(('[^3WARNING^7] Player ^5%s^7 attempted to Exploit Vehicle Spawing!!'):format(source))
        return
    end
    local SpawnPoint = vector3(Config.Zones.VehicleSpawnPoint.Pos.x, Config.Zones.VehicleSpawnPoint.Pos.y, Config.Zones.VehicleSpawnPoint.Pos.z)
    ESX.OneSync.SpawnVehicle(joaat(model), SpawnPoint, Config.Zones.VehicleSpawnPoint.Heading, props, function()
        local vehicle = NetworkGetEntityFromNetworkId()
        while GetVehicleNumberPlateText(vehicle) ~= props.plate do
            Wait(0)
        end
        TaskWarpPedIntoVehicle(GetPlayerPed(source), vehicle, -1)
    end)
    cb()
end)