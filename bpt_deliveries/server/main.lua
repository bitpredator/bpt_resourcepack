ESX = nil
ESX = exports["es_extended"]:getSharedObject()

-- Register events
RegisterServerEvent('bpt_deliveries:returnSafe:server')
RegisterServerEvent('bpt_deliveries:finishDelivery:server')
RegisterServerEvent('bpt_deliveries:removeSafeMoney:server')
RegisterServerEvent('bpt_deliveries:getPlayerJob:server')

-- Return safe deposit event
AddEventHandler('bpt_deliveries:returnSafe:server', function(deliveryType, safeReturn)
	local xPlayer = ESX.GetPlayerFromId(source)
	if safeReturn then
		local SafeMoney = 4000
		for k, v in pairs(Config.Safe) do
			if k == deliveryType then
			 SafeMoney = v
			 break
			end
		end
		xPlayer.addAccountMoney("bank", SafeMoney)
		xPlayer.showNotification(_U("safe_deposit_returned"))
	else
		xPlayer.showNotification(_U("safe_deposit_withheld"))
	end
end)

-- Finish delivery mission event
AddEventHandler('bpt_deliveries:finishDelivery:server', function(deliveryType)
    local xPlayer = ESX.GetPlayerFromId(source)
	local deliveryMoney = 800
	for k, v in pairs(Config.Rewards) do
		if k == deliveryType then
			deliveryMoney = v
			break
		end
	end
    xPlayer.addMoney(deliveryMoney)
	xPlayer.showNotification(_U("delivery_point_reward") .. tostring(deliveryMoney))
end)

-- Remove safe deposit event (On start mission)
AddEventHandler('bpt_deliveries:removeSafeMoney:server', function(deliveryType)
    local xPlayer = ESX.GetPlayerFromId(source)
	local SafeMoney = 4000
	for k, v in pairs(Config.Safe) do
		if k == deliveryType then
			SafeMoney = v
			break
		end
	end
	local PlayerMoney = xPlayer.getAccount('bank').money
	if PlayerMoney >= SafeMoney then
	 xPlayer.removeAccountMoney("bank", SafeMoney)
	 xPlayer.showNotification(_U("safe_deposit_received"))
	 TriggerClientEvent('bpt_deliveries:startJob:client', source, deliveryType)
	else
	 xPlayer.showNotification(_U("not_enough_money"))
	end
end)

-- Get the player job name
AddEventHandler('bpt_deliveries:getPlayerJob:server', function()
 local xPlayer = ESX.GetPlayerFromId(source)
 print("Player request job: " .. source .. ", " .. xPlayer.job.name)
 TriggerClientEvent('bpt_deliveries:setPlayerJob:client', source, xPlayer.job.name)
end)