local ESX = nil

ESX = exports["es_extended"]:getSharedObject()

-- Server Event for Buying:
RegisterServerEvent("bpt_pointsale:BuyItem")
AddEventHandler("bpt_pointsale:BuyItem", function(amountToBuy,totalBuyPrice,itemName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local itemLabel = ESX.GetItemLabel(itemName)
	if xPlayer.getMoney() >= totalBuyPrice then
		xPlayer.removeMoney(totalBuyPrice)
		xPlayer.addInventoryItem(itemName, amountToBuy)
		TriggerClientEvent("esx:showNotification",source,"You paid ~g~$"..totalBuyPrice.."~s~ for "..amountToBuy.."x ~y~"..itemLabel.."~s~")
	else
		TriggerClientEvent("esx:showNotification",source,"Not enough money")
	end
end)

-- Server Event for Selling:
RegisterServerEvent("bpt_pointsale:SellItem")
AddEventHandler("bpt_pointsale:SellItem", function(amountToSell,totalSellPrice,itemName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local itemLabel = ESX.GetItemLabel(itemName)
	if xPlayer.getInventoryItem(itemName).count >= amountToSell then
		xPlayer.addMoney(totalSellPrice)
		xPlayer.removeInventoryItem(itemName, amountToSell)
		TriggerClientEvent("esx:showNotification",source,"Hai venduto "..amountToSell.."x ~y~"..itemLabel.."~s~ hai guadagnato: ~g~$"..totalSellPrice.."~s~")
	else
		TriggerClientEvent("esx:showNotification",source,"Non hai questo oggetto")
	end
end)
