ESX = nil
ESX = exports["es_extended"]:getSharedObject()
-- Raccolta patate
RegisterServerEvent('farmer:raccoltapotato') 
AddEventHandler('farmer:raccoltapotato', function()
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local potato = xPlayer.getInventoryItem('potato').count
    if potato < 50 then
        TriggerClientEvent('farmer:anim', _source)
        Citizen.Wait(5000)
        local countpotato = math.random(1,5)
        xPlayer.addInventoryItem('potato', countpotato)
        TriggerClientEvent('farmer:unfreeze', _source)
    end
end)

-- Raccolta cotton
RegisterServerEvent('farmer:raccoltacotton') 
AddEventHandler('farmer:raccoltacotton', function()
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local cotton = xPlayer.getInventoryItem('cotton').count
    if cotton < 50 then
        TriggerClientEvent('farmer:anim', _source)
        Citizen.Wait(5000)
        local countcotton = math.random(1,5)
        xPlayer.addInventoryItem('cotton', countcotton)
        TriggerClientEvent('farmer:unfreeze', _source)
    end
end)

-- Raccolta apple
RegisterServerEvent('farmer:raccoltaapple') 
AddEventHandler('farmer:raccoltaapple', function()
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local apple = xPlayer.getInventoryItem('apple').count
    if apple < 50 then
        TriggerClientEvent('farmer:anim', _source)
        Citizen.Wait(5000)
        local countapple = math.random(1,5)
        xPlayer.addInventoryItem('apple', countapple)
        TriggerClientEvent('farmer:unfreeze', _source)
    end
end)

-- raccolta grain
RegisterServerEvent('farmer:raccoltagrain') 
AddEventHandler('farmer:raccoltagrain', function()
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local grain = xPlayer.getInventoryItem('grain').count
    if grain < 50 then
        TriggerClientEvent('farmer:anim', _source)
        Citizen.Wait(5000)
        local countgrain = math.random(1,5)
        xPlayer.addInventoryItem('grain', countgrain)
        TriggerClientEvent('farmer:unfreeze', _source)
    end
end)
