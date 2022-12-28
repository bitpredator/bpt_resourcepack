ESX = nil
local playersProcessingLegno = {}

ESX = exports["es_extended"]:getSharedObject()

RegisterServerEvent('bpt_taglialegna:sellLegno')
AddEventHandler('bpt_taglialegna:sellLegno', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = Config.LegnoDealerItems[itemName]
	local xItem = xPlayer.getInventoryItem(itemName)

	if not price then
	end

	if xItem.count < amount then
		TriggerClientEvent('esx:showNotification', source, _U('dealer_notenough'))
		return
	end

	price = ESX.Math.Round(price * amount)

	if Config.Guadagno then
	else
		xPlayer.addMoney(price)
	end

	xPlayer.removeInventoryItem(xItem.name, amount)

	TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', amount, xItem.label, ESX.Math.GroupDigits(price)))
end)

RegisterServerEvent('bpt_taglialegna:pickedUpLegno')
AddEventHandler('bpt_taglialegna:pickedUpLegno', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('legno')

	if xItem.weight ~= -1 and (xItem.count + 1) > xItem.weight then
		TriggerClientEvent('esx:showNotification', _source, _U('wood_inventoryfull'))
	else
		xPlayer.addInventoryItem(xItem.name, 3)
	end
end)

ESX.RegisterServerCallback('bpt_taglialegna:canPickUp', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(item)

	if xItem.weight ~= -1 and xItem.count >= xItem.weight then
		cb(false)
	else
		cb(true)
	end
end)

RegisterServerEvent('bpt_taglialegna:processLegno')
AddEventHandler('bpt_taglialegna:processLegno', function()
	if not playersProcessingLegno[source] then
		local _source = source

		playersProcessingLegno[_source] = ESX.SetTimeout(Config.Delays.LegnoProcessing, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xLegno, xLegnatagliata = xPlayer.getInventoryItem('legno'), xPlayer.getInventoryItem('legnatagliata')

			if xLegnatagliata.weight ~= -1 and (xLegnatagliata.count + 1) >= xLegnatagliata.weight then
				TriggerClientEvent('esx:showNotification', _source, _U('wood_processingfull'))
			elseif xLegno.count < 5 then
				TriggerClientEvent('esx:showNotification', _source, _U('wood_processingenough'))
			else
				xPlayer.removeInventoryItem('legno', 5)
				xPlayer.addInventoryItem('legnatagliata', 1)

				TriggerClientEvent('esx:showNotification', _source, _U('wood_processed'))
			end

			playersProcessingLegno[_source] = nil
		end)
	else
	end
end)

function CancelProcessing(playerID)
	if playersProcessingLegno[playerID] then
		ESX.ClearTimeout(playersProcessingLegno[playerID])
		playersProcessingLegno[playerID] = nil
	end
end

RegisterServerEvent('bpt_taglialegna:cancelProcessing')
AddEventHandler('bpt_taglialegna:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('esx:playerDropped', function(playerID, reason)
	CancelProcessing(playerID)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)

