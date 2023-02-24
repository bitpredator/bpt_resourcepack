local lastPlayerSuccess = {}

TriggerEvent('esx_society:registerSociety', 'baker', 'Baker', 'society_baker', 'society_baker', 'society_baker', {
    type = 'public'
})

RegisterNetEvent('bpt_bakerjob:success')
AddEventHandler('bpt_bakerjob:success', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local timeNow = os.clock()

    if xPlayer.job.name == 'baker' then
        if not lastPlayerSuccess[source] or timeNow - lastPlayerSuccess[source] > 5 then
            lastPlayerSuccess[source] = timeNow

            if xPlayer.job.grade >= 3 then
                total = total * 2
            end

            TriggerEvent('esx_addonaccount:getSharedAccount', 'society_baker', function(account)
                if account then
                    local playerMoney = ESX.Math.Round(total / 100 * 30)
                    local societyMoney = ESX.Math.Round(total / 100 * 70)

                    xPlayer.addMoney(playerMoney, "Baker Fair")
                    account.addMoney(societyMoney)

                    xPlayer.showNotification(_U('comp_earned', societyMoney, playerMoney))
                else
                    xPlayer.addMoney(total, "Baker Fair")
                    xPlayer.showNotification(_U('have_earned', total))
                end
            end)
        end
    else
        print(('[^3WARNING^7] Player ^5%s^7 attempted to ^5bpt_bakerjob:success^7 (cheating)'):format(source))
    end
end)

ESX.RegisterServerCallback("bpt_bakerjob:SpawnVehicle", function(source, cb, model , props)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "baker" then
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

ESX.RegisterServerCallback('bpt_bakerjob:getPlayerInventory', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local items = xPlayer.inventory
	local minItems = xPlayer.getInventory(true)
	cb(next(minItems) ~= nil and items or false)
end)