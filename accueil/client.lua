ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


-- Menu --
local open = false
local main = RageUI.CreateMenu("Accueil", "Intéractions disponibles")

main.Display.Header = true
main.Closed = function()
    open = false
end

cooldown = false

function Accueil() 
    if open then 
        open = false
        RageUI.Visible(main, false)
        return
    else
        open = true
        RageUI.Visible(main, true)
        CreateThread(function()
            while open do 
                RageUI.IsVisible(main, function()


                    for k, v in pairs(CFG.Menu) do
                        RageUI.Button("Appeler un "..v.nom, nil, { RightLabel = "→→"}, not cooldown , {
                            onSelected = function()
                                local notif = v.notif 
                                local job = v.job
                                local nom = v.nom 
                                local image = v.image 
                                TriggerServerEvent("Accueil", job, notif, nom, image)
                                cooldown = true 
                                Wait(v.temps)
                                cooldown = false 
                            end
                        })
                    end
                end)
            Wait(3)
            end
        end)
    end
end





Citizen.CreateThread(function()
    for k, v in pairs(CFG.Menu) do 
    while true do
  
      local wait = 750
  
        for k, v in pairs(CFG.Menu) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.x, v.y, v.z)
            
        
            if dist <= 2.0 then
                
                wait = 1
                DrawMarker(6, v.x, v.y, v.z, 0.0, 0.0, 0.0, -90.0,0.0,0.0, 1.1, 1.5, 1.1, 255, 255, 255, 255, false, false, p19, false)  

                ESX.ShowHelpNotification("Appuyez sur ~INPUT_PICKUP~ pour intéragir") 
                if IsControlJustPressed(1,51) then
                    Accueil()
                end
            end 
        end
    Citizen.Wait(wait)
    end
  end
end)