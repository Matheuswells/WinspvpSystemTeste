local matchs = {}
local matchsCount = 0

RegisterNetEvent('wins:pvp:CreateNewMatch', function (matchData)
    print('creating new match', json.encode(matchData))
    local match = {}
    match['events'] = {}
    matchs['match_'..1] = matchData
    print('matchs', json.encode(matchs))
end)

RegisterNetEvent('wins:pvp:addMatchInfo', function (info)
    print('adding match info', source, info)
    local playerTarget = nil
    local teamTarget = nil
    local matchTarget = nil
    local playerIndex = nil
    local teamIndex = nil
    local matchIndex = nil


    local found = false


    for a, match in pairs(matchs) do
        matchTarget = match
        for b, team in pairs(match) do
            teamTarget = team
            for c, playerInTeam in ipairs(team) do
                if playerInTeam.id == source then
                    playerTarget = playerInTeam
                    print('found player in match', playerInTeam.name, playerInTeam.id)
                    found = true
                    matchIndex = a
                    teamIndex = b
                    playerIndex = c
                end
            end
        end
    end

    if found then
        if playerTarget ~= nil and matchIndex ~= nil then
            print('adding event to match', playerTarget.name, info)
            matchs[matchIndex]['events'] = {{source,info}}
            print('matchs222', json.encode(matchs))
           matchs[matchIndex][teamIndex][playerIndex].status = info
        end
    end
   
    if checkIfAllPlayersInTeamAreDead(matchs[matchIndex][teamIndex]) then   
        --for each player in red and blue team sent event match ended
        local winner = nil
        local playerAliveInBlue = 0
        local playerAliveInRed = 0

        for _, player in ipairs(matchs[matchIndex]['blue']) do
            if player.status == 'alive' then
                playerAliveInBlue = playerAliveInBlue + 1
            end
        end

        for _, player in ipairs(matchs[matchIndex]['red']) do
            if player.status == 'alive' then
                playerAliveInRed = playerAliveInRed + 1
            end
        end

        if playerAliveInBlue == 0 then
            winner = 'red'
        else
            winner = 'blue'
        end



        for _, player in ipairs(matchs[matchIndex]['blue']) do
            TriggerClientEvent('wins:pvp:matchEnded', player.id, matchs[matchIndex]['events'], winner)
        end
        for _, player in ipairs(matchs[matchIndex]['red']) do
            TriggerClientEvent('wins:pvp:matchEnded', player.id, matchs[matchIndex]['events'], winner)
        end

        matchs[matchIndex] = nil
        matchsCount = matchsCount - 1
    end
end)


function checkIfAllPlayersInTeamAreDead(team)

    local allDead = true
    for _, player in ipairs(team) do
        if player.status == 'alive' then
            allDead = false
        end
    end

    return allDead
end
