local QBCore = exports['qb-core']:GetCoreObject() 
local playerRentedVehicles = {} -- Track rented vehicles per player

-- 🎁 **Give Rewards to Players (All Items Guaranteed)**
RegisterNetEvent("oxy:giveReward", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not Player then return end

    -- 💰 **Give Cash Reward**
    local cashReward = Config.RewardBase + (Config.RewardMultiplier * math.random(1, 5))
    Player.Functions.AddMoney("cash", cashReward)

    -- Log cash reward
    print(("[Oxy Run] Player %s received $%s cash."):format(GetPlayerName(src), cashReward))

    -- 🎁 **Give Every Item in Config.RewardItems**
    local receivedItems = {}
    for _, item in pairs(Config.RewardItems) do
        local amount = math.random(item.minAmount, item.maxAmount)
        Player.Functions.AddItem(item.name, amount)
        table.insert(receivedItems, {name = item.name, amount = amount})

        -- Log item reward
        print(("[Oxy Run] Player %s received %sx %s."):format(GetPlayerName(src), amount, item.name))

        -- 🔔 Notify Player in Inventory UI
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[item.name], "add")
    end

    -- 📢 Notify Player of Rewards
    TriggerClientEvent("oxy:notifyReward", src, cashReward, receivedItems)
end)

-- 🚗 **Handle Vehicle Rental with Money Validation**
RegisterNetEvent("oxy:rentVehicle", function(vehicle)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not Player then return end

    -- Check if the player already has a rented vehicle
    if playerRentedVehicles[src] then
        TriggerClientEvent("QBCore:Notify", src, "You must return the current vehicle before renting another!", "error")
        return
    end

    -- Check if the player has enough money to rent the vehicle
    if Player.PlayerData.money.cash >= vehicle.price then
        -- Deduct money and allow rental
        Player.Functions.RemoveMoney("cash", vehicle.price)
        TriggerClientEvent("oxy:spawnVehicle", src, vehicle.model, vehicle.price)
        playerRentedVehicles[src] = { vehicle = vehicle.model }
        print(("[Oxy Run] Player %s rented a %s for $%s."):format(GetPlayerName(src), vehicle.model, vehicle.price))
    else
        -- Notify player of insufficient funds
        TriggerClientEvent("QBCore:Notify", src, "Not enough money.", "error")
    end
end)

-- 🚘 **Handle Vehicle Return**
RegisterNetEvent("oxy:returnVehicle", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if playerRentedVehicles[src] then
        playerRentedVehicles[src] = nil
        TriggerClientEvent("QBCore:Notify", src, "Vehicle returned successfully!", "success")
        TriggerClientEvent("oxy:removeWaypoint", src) -- Clear waypoint
        print(("[Oxy Run] Player %s returned their rented vehicle."):format(GetPlayerName(src)))
    else
        TriggerClientEvent("QBCore:Notify", src, "You do not have a rented vehicle to return.", "error")
    end
end)

-- 💰 **Deduct Money for Bribery**
RegisterNetEvent("oxy:deductMoney", function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    -- Ensure the player has enough money
    if Player.PlayerData.money.cash >= amount then
        Player.Functions.RemoveMoney("cash", amount)
        TriggerClientEvent("QBCore:Notify", src, "Bribe successful! $" .. amount .. " has been deducted.", "success")
        print(("[Oxy Run] Player %s paid a bribe of $%s."):format(GetPlayerName(src), amount))
    else
        TriggerClientEvent("QBCore:Notify", src, "You don’t have enough money to bribe!", "error")
        print(("[Oxy Run] Player %s failed to pay a bribe due to insufficient funds."):format(GetPlayerName(src)))
    end
end)
