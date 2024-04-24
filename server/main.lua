local config = require 'config'
local hud = config.HUD
local QBCore
if hud.framework == 'qb-core' then
    QBCore = exports[hud.framework]:GetCoreObject()
elseif hud.framework == 'esx' then
    ESX = exports["es_extended"]:getSharedObject()
end
local player
local ResetStress = false

--[[
lib.addCommand('cash', {help = 'Check Cash Balance'}, function(source, args)
    if hud.framework == 'qbx_core' then
        player = exports.qbx_core:GetPlayer(source)
    else
        player = QBCore.Functions.GetPlayer(source)
    end
    local cashamount = player.PlayerData.money.cash
    TriggerClientEvent('hud:client:ShowAccounts', source, 'cash', cashamount)
end)

lib.addCommand('bank', { help = 'Check Bank Balance'}, function(source, args)
    if hud.framework == 'qbx_core' then
        player = exports.qbx_core:GetPlayer(source)
    else
        player = QBCore.Functions.GetPlayer(source)
    end
    local bankamount = player.PlayerData.money.bank
    TriggerClientEvent('hud:client:ShowAccounts', source, 'bank', bankamount)
end)
]]

RegisterNetEvent('hud:server:GainStress', function(amount)
    if hud.disableStress then return end
    local src = source
    if hud.framework == 'qbx_core' then
        player = exports.qbx_core:GetPlayer(src)
    else
        player = ESX.GetPlayerFromId(src)
    end
    local Job = player.job.name
    local newStress
    if not player or hud.whitelistedJobs[Job] then return end
    if not ResetStress then
        if not player.get('stress') then
            player.set('stress', newStress)
        end
        newStress = player.get('stress') + amount
        if newStress <= 0 then newStress = 0 end
    else
        newStress = 0
    end
    if newStress > 100 then
        newStress = 100
    end
    player.set('stress', newStress)
    TriggerClientEvent('hud:client:UpdateStress', src, newStress)
    if hud.framework == 'qbx_core' then
        exports.qbx_core:Notify(src, "Stress gained", 'inform', 2500, nil, nil, {'#141517', '#ffffff'}, 'brain', '#C53030')
    else
        TriggerClientEvent('ox_lib:Notify', src, "Stress Gained", 'Warning', 2500)
    end
end)

RegisterNetEvent('hud:server:RelieveStress', function(amount)
    if hud.disableStress then return end
    local src = source
    if hud.framework == 'qbx_core' then
        player = exports.qbx_core:GetPlayer(src)
    else
        player = ESX.GetPlayerFromId(src)
    end
    local newStress
    if not player then return end
    if not ResetStress then
        if not player.get('stress') then
            player.set('stress', 0)
        end
        newStress = player.get('stress') - amount
        if newStress <= 0 then newStress = 0 end
    else
        newStress = 0
    end
    if newStress > 100 then
        newStress = 100
    end
    player.set('stress', newStress)
    TriggerClientEvent('hud:client:UpdateStress', src, newStress)
    if hud.framework == 'qbx_core' then
        exports.qbx_core:Notify(src, "Relived stress", 'inform', 2500, nil, nil, {'#141517', '#ffffff'}, 'brain', '#0F52BA')
    else
        TriggerClientEvent('ox_lib:notify', src, { type = "warning", description = "Stress Gained" })
    end
end)
