RegisterServerEvent('fuel:getPlayerMoney')
AddEventHandler('fuel:getPlayerMoney', function(source)
	function getMoney(source, callback)
	    local steam = exports.SQLquerries:steamID(source)
	    MySQL.Async.fetchAll("SELECT money FROM users WHERE identifier = @identifier", 
				{['@identifier'] = steam },
			    function(result)
				if result[1] then 
				    callback(result[1].money)
				else 
				    callback(nil)
				end
			    end
	    )
	end
   	getMoney(source, function(money)
        	TriggerClientEvent('fuel:sendPlayerMoney', source, money)
    	end)
end)

RegisterServerEvent('fuel:setPlayerMoney')
AddEventHandler('fuel:setPlayerMoney', function(source, money)
	local amount = Round(money)
	function setMoney(source, bool, amount)
		local steam = exports.SQLquerries:steamID(source)
		local diff
		if bool then
			diff = amount
		else
			diff = 0 - amount
		end
		MySQL.Async.execute('UPDATE users SET money = (money + (@amount)) WHERE identifier = @identifier',
				{
					['@amount'] = diff, 
					['@identifier'] = steam
				},
				function(result) end)
	end
	setMoney(source, false, amount)
end)

-----------

function Round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end
