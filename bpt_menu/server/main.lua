ESX = exports["es_extended"]:getSharedObject()

do
	local origRegisterServerEvent = RegisterServerEvent
	local origEsxRegisterServerCallback = ESX.RegisterServerCallback

	RegisterServerEvent = function(eventName, ...)
		local endIdx = ('bpt_menu:'):len()

		if eventName:sub(1, endIdx) == 'bpt_menu' then
			local oldEventName = ('bpt-PersonalMenu:%s'):format(eventName:sub(endIdx + 1))

			origRegisterServerEvent(oldEventName)
			AddEventHandler(oldEventName, function()
				DropPlayer(source,
					(
						"Server detected a potentially abusive behaviour.\n"
						.. "If you're not an abuser please contact the server developer so he can fix the underlying issue.\n\n"
						.. "- DEBUG INFO -\n"
						.. "Resource Name : %s\n"
						.. "Event Name : %s"
					):format(
						GetCurrentResourceName(),
						oldEventName
					)
				)
			end)
		end

		return origRegisterServerEvent(eventName, ...)
	end

	ESX.RegisterServerCallback = function(eventName, ...)
		local endIdx = ('bpt_menu:'):len()

		if eventName:sub(1, endIdx) == 'bpt_menu' then
			local oldEventName = ('bpt-PersonalMenu:%s'):format(eventName:sub(endIdx + 1))

			origEsxRegisterServerCallback(oldEventName, function(source)
				DropPlayer(source,
					(
						"Server detected a potentially abusive behaviour.\n"
						.. "If you're not an abuser please contact the server developer so he can fix the underlying issue.\n\n"
						.. "- DEBUG INFO -\n"
						.. "Resource Name : %s\n"
						.. "Event Name : %s"
					):format(
						GetCurrentResourceName(),
						oldEventName
					)
				)
			end)
		end

		return origEsxRegisterServerCallback(eventName, ...)
	end
end

function getAdminCommand(name)
	for i = 1, #Config.Admin do
		if Config.Admin[i].name == name then
			return i
		end
	end

	return false
end

function isAuthorized(index, group)
	for i = 1, #Config.Admin[index].groups do
		if Config.Admin[index].groups[i] == group then
			return true
		end
	end

	return false
end

ESX.RegisterServerCallback('bpt_menu:Bill_getBills', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM billing WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		local bills = {}

		for i = 1, #result do
			bills[#bills + 1] = {
				id = result[i].id,
				label = result[i].label,
				amount = result[i].amount
			}
		end

		cb(bills)
	end)
end)

ESX.RegisterServerCallback('bpt_menu:Admin_getUsergroup', function(source, cb)
	cb(ESX.GetPlayerFromId(source).getGroup() or 'user')
end)

local function makeTargetedEventFunction(fn)
	return function(target, ...)
		if tonumber(target) == -1 then return end
		fn(target, ...)
	end
end

-- Admin Menu --
RegisterServerEvent('bpt_menu:Admin_BringS')
AddEventHandler('bpt_menu:Admin_BringS', makeTargetedEventFunction(function(playerId, target)
	local xPlayer = ESX.GetPlayerFromId(source)
	local plyGroup = xPlayer.getGroup()

	if isAuthorized(getAdminCommand('bring'), plyGroup) or isAuthorized(getAdminCommand('goto'), plyGroup) then
		TriggerClientEvent('bpt_menu:Admin_BringC', playerId, GetEntityCoords(GetPlayerPed(target)))
	end
end))

RegisterServerEvent('bpt_menu:Admin_giveCash')
AddEventHandler('bpt_menu:Admin_giveCash', function(amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local plyGroup = xPlayer.getGroup()

	if isAuthorized(getAdminCommand('givemoney'), plyGroup) then
		xPlayer.addAccountMoney('cash', amount)
	    TriggerClientEvent('esx:showNotification', xPlayer.source, _U'you_received_money_cash'):format(amount)
	end
end)

RegisterServerEvent('bpt_menu:Admin_giveBank')
AddEventHandler('bpt_menu:Admin_giveBank', function(amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local plyGroup = xPlayer.getGroup()

	if isAuthorized(getAdminCommand('givebank'), plyGroup) then
		xPlayer.addAccountMoney('bank', amount)
        TriggerClientEvent('esx:showNotification', xPlayer.source, _U'you_received_money_bank'):format(amount)
	end
end)
