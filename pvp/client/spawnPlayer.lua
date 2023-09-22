
local redSpawn = {x = 736.617112646484, y = -216.45768737793, z = 66.114608764648 , heading = 245.81423950195}
local blueSpawn = {x = 804.87670898438, y = -249.95085144043, z = 65.960021972656, heading = 65.553901672363 }
local defaultSpawn = {x = 759.43615722, y = -257.0469665, z = 66.095413208, heading = 0.0}
local spawns ={}
spawns['red'] = redSpawn
spawns['blue'] = blueSpawn
spawns['default'] = defaultSpawn
playerInMatch = false

local bot = nil
local botInverseTeam = nil
function giveWeapon(hash, player)
    GiveWeaponToPed(player, GetHashKey(hash), 999, false, false)
end

RegisterNetEvent('wins:pvp:spawnPlayer', function (playerData)
    local player = source
    print('spawning player', json.encode(playerData))

    --set player location to the match spawn  group
    print('spawns[playerData.team]', playerData.team, spawns[playerData.team].x)
    local cords = spawns[playerData.team]
    SetEntityCoords(PlayerPedId(), cords.x, cords.y, cords.z, 1, 0 ,0 ,1)
    SetEntityHeading(PlayerPedId(), cords.heading)
    if playerData.team == 'blue' then
        ApplyBluePedProps(PlayerPedId())
        ApplyBluePedWeapons(PlayerPedId())
    else
        ApplyRedPedProps(PlayerPedId())
        ApplyRedPedWeapons(PlayerPedId())
    end
    playerInMatch = true
end)

RegisterNetEvent('wins:pvp:matchEnded', function (events, winner)
    print('match ended', json.encode(events))
    print('winner', winner)
    playerInMatch = false
    local cords = spawns['default']
    ApplyBlackPedProps()
    revivePed(GetPlayerPed(-1))
    SetEntityCoords(PlayerPedId(), cords.x, cords.y, cords.z, 1, 0 ,0 ,1)
    SetEntityHeading(PlayerPedId(), cords.heading)
    RemoveAllPedWeapons(GetPlayerPed(-1), true)
    ApplyBlackPedProps(GetPlayerPed(-1))

    if bot ~= nil then
        DeletePed(bot)
    end
end)


RegisterNetEvent('wins:pvp:spawnBot', function (playerData)
    print('spawning bot', json.encode(playerData))
    RequestModel(GetHashKey('mp_m_freemode_01'))

        while not HasModelLoaded(GetHashKey('mp_m_freemode_01')) do
            Wait(15)
        end

    if(playerData.team == 'blue') then
        
        bot = CreatePed(4, GetHashKey('mp_m_freemode_01'), spawns['blue'].x, spawns['blue'].y, spawns['blue'].z, spawns['blue'].heading, true, true)

        botInverseTeam = 'red'
        ApplyBluePedProps(bot)
        ApplyBluePedWeapons(bot)
        SetEntityAsMissionEntity(bot, true, true)
        TaskCombatPed(bot,GetPlayerPed(-1) , 0, 16)
        
    else
        bot = CreatePed(4, GetHashKey('mp_m_freemode_01'), spawns['red'].x, spawns['red'].y, spawns['red'].z, spawns['red'].heading, true, true)
        botInverseTeam = 'blue'
        ApplyRedPedProps(bot)
        ApplyRedPedWeapons(bot)
        SetEntityAsMissionEntity(bot, true, true)
        TaskCombatPed(bot, GetPlayerPed(-1), 0, 16)
    end
end)

function ApplyBluePedWeapons(player)
    RemoveAllPedWeapons(player, true)
    giveWeapon("weapon_carbinerifle_mk2", player)
    SetCurrentPedWeapon(player,"weapon_carbinerifle_mk2", true)

end

function ApplyRedPedWeapons(player) 
    RemoveAllPedWeapons(player, true)
    giveWeapon("weapon_assaultrifle_mk2", player)
    SetCurrentPedWeapon(player,"weapon_assaultrifle_mk2", true)
end

function ApplyBluePedProps(player)
    SetPedComponentVariation(player, 1, 55, 0, 0) -- mask
    SetPedComponentVariation(player, 3, 17, 0, 0) -- torso
    SetPedComponentVariation(player, 4, 10, 0, 0) -- legs
    SetPedComponentVariation(player, 5, 45, 0, 0) -- bags
    SetPedComponentVariation(player, 2, 4, 0, 0) -- hair
    SetPedComponentVariation(player, 6, 24, 0, 0) -- shoes
    SetPedComponentVariation(player, 7, 38, 0, 0) -- accessories
    SetPedComponentVariation(player, 8, 35, 0, 0) -- tshirt
    SetPedComponentVariation(player, 9, 0, 0, 0) -- body armor
    SetPedComponentVariation(player, 10, 0, 0, 0) -- decals
    SetPedComponentVariation(player, 11, 167, 2, 0) -- jacket
    SetPedPropIndex(player, 0, 52, 0, 0) -- hat 
    SetPedPropIndex(player, 1, 25, 4, 0) -- glasses
end

function ApplyRedPedProps(player)
    SetPedComponentVariation(player, 1, 55, 0, 0) -- mask
    SetPedComponentVariation(player, 2, 4, 0, 0) -- hair
    SetPedComponentVariation(player, 3, 17, 0, 0) -- torso
    SetPedComponentVariation(player, 4, 10, 0, 0) -- legs
    SetPedComponentVariation(player, 5, 45, 0, 0) -- bags
    SetPedComponentVariation(player, 6, 24, 0, 0) -- shoes
    SetPedComponentVariation(player, 7, 38, 0, 0) -- accessories
    SetPedComponentVariation(player, 8, 35, 0, 0) -- tshirt
    SetPedComponentVariation(player, 9, 0, 0, 0) -- body armor
    SetPedComponentVariation(player, 10, 0, 0, 0) -- decals
    SetPedComponentVariation(player, 11, 167, 0, 0) -- jacket
    SetPedPropIndex(player, 0, 52, 0, 0) -- hat 
    SetPedPropIndex(player, 1, 25, 4, 0) -- glasses
end

function ApplyBlackPedProps(player)
     SetPedComponentVariation(player, 1, 52, 0, 0) -- mask
    SetPedComponentVariation(player, 2, 4, 0, 0) -- hair
    SetPedComponentVariation(player, 3, 17, 0, 0) -- torso
    SetPedComponentVariation(player, 4, 10, 0, 0) -- legs
    SetPedComponentVariation(player, 5, 45, 0, 0) -- bags
    SetPedComponentVariation(player, 6, 24, 0, 0) -- shoes
    SetPedComponentVariation(player, 7, 38, 0, 0) -- accessories
    SetPedComponentVariation(player, 8, 35, 0, 0) -- tshirt
    SetPedComponentVariation(player, 9, 0, 0, 0) -- body armor
    SetPedComponentVariation(player, 10, 0, 0, 0) -- decals
    SetPedComponentVariation(player, 11, 32, 0, 0) -- jacket
    SetPedPropIndex(player, 0, 52, 0, 0) -- hat 
    SetPedPropIndex(player, 1, 25, 4, 0) -- glasses
    RemoveAllPedWeapons(GetPlayerPed(-1), true)
end

function revivePed(ped)
	local playerPos = GetEntityCoords(ped, true)

	NetworkResurrectLocalPlayer(playerPos, true, true, false)
	SetPlayerInvincible(ped, false)
	ClearPedBloodDamage(ped)
end

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(200)
        if playerInMatch == true then
            local playerPed = GetPlayerPed(-1)
            if IsEntityDead(playerPed) then
                TriggerServerEvent('wins:pvp:addMatchInfo', 'dead')
                local cords = spawns['default']
                ApplyBlackPedProps()
                revivePed(playerPed)
                SetEntityCoords(PlayerPedId(), cords.x, cords.y, cords.z, 1, 0 ,0 ,1)
                SetEntityHeading(PlayerPedId(), cords.heading)
                playerInMatch = false
            end
        end
    end
end)

Citizen.CreateThread(function ()
    --check if bot is dead 
    while true do
        Citizen.Wait(200)
        if bot ~= nil then
            if IsEntityDead(bot) and playerInMatch then
                print('bot dies')
                TriggerEvent('wins:pvp:matchEnded', {{'bot', "dead"}} , botInverseTeam )
                bot = nil
            end
        end
    end
end)


function addNPC(x, y, z, heading, hash, model)
    RequestModel(GetHashKey(model))
    while not HasModelLoaded(GetHashKey(model)) do
        Wait(15)
    end
 
    ped = CreatePed(4, hash, x, y, z - 1, 3374176, false, true)
    SetEntityHeading(ped, heading)
end