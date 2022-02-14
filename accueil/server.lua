ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('Accueil')
AddEventHandler('Accueil', function(job,notif,nom,image)

	local xPlayers = ESX.GetPlayers()
	for i = 1, #xPlayers, 1 do

		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == job then		
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], notif, '~b~Appel', 'Un '..nom..' est appelé à l\'accueil.', image, 1)
        end
    end


end)
