RegisterServerEvent('fuel:getPlayerMoney')
AddEventHandler('fuel:getPlayerMoney', function(source)
    exports.SQLquerries:getMoney(source, function(money)
        TriggerClientEvent('fuel:sendPlayerMoney', source, money)
    end)
end)

RegisterServerEvent('fuel:setPlayerMoney')
AddEventHandler('fuel:setPlayerMoney', function(source, money)
	local amount = Round(money)
	exports.SQLquerries:setMoney(source, false, amount)
end)

-----------

function Round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end