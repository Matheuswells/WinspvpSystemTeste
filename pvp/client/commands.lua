RegisterCommand('pvp', function(source, args, rawCommand)
    print('start searching for match')    
    if not playerInMatch then
        TriggerServerEvent('wins:pvp:startMatchmaking', GetPlayerPed(-1))
    else
        print('player is already in match')
    end
end, false)

RegisterCommand('stop', function(source, args, rawCommand)
    print('stop searching for match')    
    TriggerServerEvent('wins:pvp:stopMatchmaking')
end, false)

RegisterCommand('bot', function(source, args, rawCommand)
    print('inserting bot in queue')    
    TriggerServerEvent('wins:pvp:insertBot')
end, false)

RegisterCommand('cq', function(source, args, rawCommand)
    print('clearing queue')    
    TriggerServerEvent('wins:pvp:clearQueue')
end, false)


RegisterCommand('blue', function ()
    SetPedComponentVariation(PlayerPedId(), 1, 55, 0, 0) -- mask
    SetPedComponentVariation(PlayerPedId(), 2, 4, 0, 0) -- hair
    SetPedComponentVariation(PlayerPedId(), 3, 17, 0, 0) -- torso
    SetPedComponentVariation(PlayerPedId(), 4, 10, 0, 0) -- legs
    SetPedComponentVariation(PlayerPedId(), 5, 45, 0, 0) -- bags
    SetPedComponentVariation(PlayerPedId(), 6, 24, 0, 0) -- shoes
    SetPedComponentVariation(PlayerPedId(), 7, 38, 0, 0) -- accessories
    SetPedComponentVariation(PlayerPedId(), 8, 35, 0, 0) -- tshirt
    SetPedComponentVariation(PlayerPedId(), 9, 0, 0, 0) -- body armor
    SetPedComponentVariation(PlayerPedId(), 10, 0, 0, 0) -- decals
    SetPedComponentVariation(PlayerPedId(), 11, 167, 2, 0) -- jacket
    SetPedPropIndex(PlayerPedId(), 0, 52, 0, 0) -- hat 
    SetPedPropIndex(PlayerPedId(), 1, 25, 4, 0) -- glasses
end)
RegisterCommand('red', function ()
    SetPedComponentVariation(PlayerPedId(), 1, 55, 0, 0) -- mask
    SetPedComponentVariation(PlayerPedId(), 2, 4, 0, 0) -- hair
    SetPedComponentVariation(PlayerPedId(), 3, 17, 0, 0) -- torso
    SetPedComponentVariation(PlayerPedId(), 4, 10, 0, 0) -- legs
    SetPedComponentVariation(PlayerPedId(), 5, 45, 0, 0) -- bags
    SetPedComponentVariation(PlayerPedId(), 6, 24, 0, 0) -- shoes
    SetPedComponentVariation(PlayerPedId(), 7, 38, 0, 0) -- accessories
    SetPedComponentVariation(PlayerPedId(), 8, 35, 0, 0) -- tshirt
    SetPedComponentVariation(PlayerPedId(), 9, 0, 0, 0) -- body armor
    SetPedComponentVariation(PlayerPedId(), 10, 0, 0, 0) -- decals
    SetPedComponentVariation(PlayerPedId(), 11, 167, 0, 0) -- jacket
    SetPedPropIndex(PlayerPedId(), 0, 52, 0, 0) -- hat 
    SetPedPropIndex(PlayerPedId(), 1, 25, 4, 0) -- glasses
end)

RegisterCommand('black', function ()
    SetPedComponentVariation(PlayerPedId(), 1, 52, 0, 0) -- mask
    SetPedComponentVariation(PlayerPedId(), 2, 4, 0, 0) -- hair
    SetPedComponentVariation(PlayerPedId(), 3, 17, 0, 0) -- torso
    SetPedComponentVariation(PlayerPedId(), 4, 10, 0, 0) -- legs
    SetPedComponentVariation(PlayerPedId(), 5, 45, 0, 0) -- bags
    SetPedComponentVariation(PlayerPedId(), 6, 24, 0, 0) -- shoes
    SetPedComponentVariation(PlayerPedId(), 7, 38, 0, 0) -- accessories
    SetPedComponentVariation(PlayerPedId(), 8, 35, 0, 0) -- tshirt
    SetPedComponentVariation(PlayerPedId(), 9, 0, 0, 0) -- body armor
    SetPedComponentVariation(PlayerPedId(), 10, 0, 0, 0) -- decals
    SetPedComponentVariation(PlayerPedId(), 11, 32, 0, 0) -- jacket
    SetPedPropIndex(PlayerPedId(), 0, 52, 0, 0) -- hat 
    SetPedPropIndex(PlayerPedId(), 1, 25, 4, 0) -- glasses
    RemoveAllPedWeapons(GetPlayerPed(-1), true)
end)
