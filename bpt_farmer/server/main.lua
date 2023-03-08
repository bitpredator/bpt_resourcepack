ESX = nil
ESX = exports["es_extended"]:getSharedObject()
-- collection potato
RegisterServerEvent('farmer:collectionpotato') 
AddEventHandler('farmer:collectionpotato', function()
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local potato = xPlayer.getInventoryItem('potato').count
    if potato < 50 then
        TriggerClientEvent('farmer:anim', _source)
        Wait(5000)
        local countpotato = math.random(1,5)
        xPlayer.addInventoryItem('potato', countpotato)
        TriggerClientEvent('farmer:unfreeze', _source)
    end
end)

-- collection cotton
RegisterServerEvent('farmer:collectioncotton') 
AddEventHandler('farmer:collectioncotton', function()
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local cotton = xPlayer.getInventoryItem('cotton').count
    if cotton < 50 then
        TriggerClientEvent('farmer:anim', _source)
        Wait(5000)
        local countcotton = math.random(1,5)
        xPlayer.addInventoryItem('cotton', countcotton)
        TriggerClientEvent('farmer:unfreeze', _source)
    end
end)

-- collection apple
RegisterServerEvent('farmer:collectionapple') 
AddEventHandler('farmer:collectionapple', function()
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local apple = xPlayer.getInventoryItem('apple').count
    if apple < 50 then
        TriggerClientEvent('farmer:anim', _source)
        Wait(5000)
        local countapple = math.random(1,5)
        xPlayer.addInventoryItem('apple', countapple)
        TriggerClientEvent('farmer:unfreeze', _source)
    end
end)

-- collection grain
RegisterServerEvent('farmer:collectiongrain') 
AddEventHandler('farmer:collectiongrain', function()
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local grain = xPlayer.getInventoryItem('grain').count
    if grain < 50 then
        TriggerClientEvent('farmer:anim', _source)
        Wait(5000)
        local countgrain = math.random(1,5)
        xPlayer.addInventoryItem('grain', countgrain)
        TriggerClientEvent('farmer:unfreeze', _source)
    end
end)
