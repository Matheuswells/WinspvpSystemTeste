local queue = {}
local groupCount = 0
local creatingMatch = false


function getGroupCount(queue)
    local groupsAvailableCount = 0
    for group, _ in pairs(queue) do
        groupsAvailableCount = groupsAvailableCount + 1
    end

    return groupsAvailableCount
end

RegisterNetEvent('wins:pvp:startMatchmaking')
AddEventHandler('wins:pvp:startMatchmaking', function (playerPedId)
    print('playerpedid', playerPedId )
    local player = playerPedId
    local playerName = GetPlayerName(source)
    local newGroupName = 'group_' .. groupCount
    print('start searching for match', playerName, playerId)
    local playerData = {
        id = source,
        name = playerName,
        group = newGroupName,
        status = 'alive'
    }

    for groupName, groupData in pairs(queue) do
        for _, playerData in ipairs(groupData) do
            if playerData.id == player then
                return
            end
        end
    end

    queue[newGroupName] = {}

    table.insert(queue[newGroupName], playerData)
    groupCount = groupCount + 1
end)

RegisterNetEvent('wins:pvp:insertBot')
AddEventHandler('wins:pvp:insertBot', function ()
    local player = source
    local playerName = GetPlayerName(player)
    local newGroupName = 'group_' .. groupCount
    print('start searching for match', playerName)
    local playerData = {
        id = 'bot',
        name = 'botzin',
        group = newGroupName,
        status = 'alive'
    }
    queue[newGroupName] = {}

    table.insert(queue[newGroupName], playerData)
    groupCount = groupCount + 1
end)

RegisterNetEvent('wins:pvp:stopMatchmaking')
AddEventHandler('wins:pvp:stopMatchmaking', function ()
    local player = source
    local playerName = GetPlayerName(player)
    print('stop searching for match', playerName)
    for groupName, groupData in pairs(queue) do
        for _, playerData in ipairs(groupData) do
            if playerData.id == player then
                table.remove(queue[groupName], _)
                if #queue[groupName] == 0 then
                    queue[groupName] = nil
                end
                break
            end
        end
    end
    
end)

RegisterNetEvent('wins:pvp:clearQueue', function ()
    queue = {}
end)

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(1000)
        local groupsAvailableCount = 0
        for group, _ in pairs(queue) do
            groupsAvailableCount = groupsAvailableCount + 1
        end

        if groupsAvailableCount >= 2 and creatingMatch == false then
            local groupPair = getGroupPair(queue)

            print('groupPair', json.encode(groupPair))  

            local realPlayerBlue = nil
            local realPlayerRed = nil

            for _, player in ipairs(groupPair['blue']) do
                if player.id ~= 'bot' then
                    realPlayerBlue = player
                end
            end

            for _, player in ipairs(groupPair['red']) do
                if player.id ~= 'bot' then
                    realPlayerRed = player
                end
            end

            local realplayernotnil = realPlayerBlue or realPlayerRed
            print('realplayernotnil', json.encode(realplayernotnil))


            spawnGroup(groupPair['blue'], realplayernotnil)
            spawnGroup(groupPair['red'], realplayernotnil)
            TriggerEvent('wins:pvp:CreateNewMatch', groupPair)

        end
        creatingMatch = false
    end
end)





function spawnGroup(group, realplayer)
    for _, player in ipairs(group) do
        print('spawning player', player.name, player.id)
        if player.id ~= 'bot' then
            print('heeeeereeee')
            TriggerClientEvent('wins:pvp:spawnPlayer', player.id, player)
        else
            TriggerClientEvent('wins:pvp:spawnBot', realplayer.id , player)
        end
    end
end

-------------------------------------------------------


function getGroupPair(queueForNextMatch)
    creatingMatch = true
    local groupNamesList = {}
    for groupName, groupData in pairs(queueForNextMatch) do
        table.insert(groupNamesList, groupName)
    end
    local red = queueForNextMatch[groupNamesList[getGroupCount(queueForNextMatch)]]
    local blue = queueForNextMatch[groupNamesList[getGroupCount(queueForNextMatch) - 1]]

    queue[groupNamesList[getGroupCount(queueForNextMatch)]] = nil
    queue[groupNamesList[getGroupCount(queueForNextMatch)]] = nil

    for _, player in ipairs(red) do
        player.team = 'red'
    end

    for _, player in ipairs(blue) do
        player.team = 'blue'
    end

    local teams = {}

    teams['red'] = red
    teams['blue'] = blue
    
    -- print('red', json.encode(red))
    -- print('blue', json.encode(blue))
    -- print('teams', json.encode(teams))

    return teams

end



-- local teamRed = {}
-- local teamBlue = {}

-- for groupName, groupData in pairs(queueForNextMatch) do
--     for _, player in ipairs(groupData.players) do
--         player.groupName = groupName
--     end
-- end



-- function completeTeamWithGroup(team, queue)
--     local finalTeam = team
--     local teamPlayerCount = #team.players
--     local groupsAvailableCount = getGroupCount(queue)

--     for groupName, groupData in pairs(queue) do
--         local playerCount = #groupData.players
--         if playerCount + teamPlayerCount == 5 or playerCount + teamPlayerCount < 5 then
--             for _, player in ipairs(groupData.players) do
--                 table.insert(finalTeam.players, player)
--                 queueForNextMatch[groupName] = nil
--             end
--             teamPlayerCount = #team.players
--             break
--         end
--     end
    
--     return finalTeam
-- end


function startMatch(teams)

    local teamRed = teams['red']
    local teamBlue = teams['blue']
 
    print('------------------------------')
    print('TeamRed:')
    print('------------------------------')
    for _, player in pairs(teamRed.players) do
      print(_,player.name, player.groupName)
    end
    print('------------------------------')
    print('TeamBlue:')
    print('------------------------------')
    for _, player in pairs(teamBlue.players) do
        print(_,player.name, player.groupName)
    end
    print('------------------------------')
  -- startMatch
  -- spawnPlayers
  -- ...
end



-- function joinGroupsInTeam(queue)

--   local maxGroup = getBigestGroup(queueForNextMatch)
 
--   teamRed = queueForNextMatch[maxGroup]
--   queueForNextMatch[maxGroup] = nil

--   while not checkIfTeamIsComplete(teamRed) do
--     teamRed = completeTeamWithGroup(teamRed, queueForNextMatch)
--   end

--   maxGroup = getBigestGroup(queue)
--   teamBlue = queueForNextMatch[maxGroup]
--   queueForNextMatch[maxGroup] = nil

--   while not checkIfTeamIsComplete(teamBlue) do
--     teamBlue = completeTeamWithGroup(teamBlue, queueForNextMatch)
--   end

--   local teams = {}

--   teams['red'] = teamRed
--   teams['blue'] = teamBlue

--     startMatch(teams)

-- end

-- joinGroupsInTeam(queueForNextMatch)








function getBigestGroup(queue)
    local maxGroup = nil
    local maxPlayerCount = 0
  
    for groupName, groupData in pairs(queue) do
      local playerCount = #groupData.players
      if playerCount > maxPlayerCount then
          maxGroup = groupName
          maxPlayerCount = playerCount
      end
    end
    return maxGroup
end

function checkIfTeamIsComplete(team)
    if #team.players == 5 then
        return true
    else
        return false
    end
end