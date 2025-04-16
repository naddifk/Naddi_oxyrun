local QBCore = exports['qb-core']:GetCoreObject()
local currentNPC = nil
local currentNPCText = nil
local isHandshaking = false
local missionStartTime = nil
local npcCount = 0 
local currentVehicle = nil
local currentNPCIndex = 1 -- Track which NPC is currently active
local isMissionActive = false
local currentBlip = nil -- Stores the current NPC waypoint

-- 🚶 **Monitor Player Proximity to Rental, Return & NPC Locations**
CreateThread(function()
    while true do
        local sleep = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        -- 🚗 **Check Rental Locations**
        for _, location in pairs(Config.RentalLocations) do
            local dist = #(playerCoords - location.coords)
            if dist < 10 then
                sleep = 5
                DrawText3D(location.coords, "[E] Rent Vehicle")
                if IsControlJustReleased(0, 38) and dist < 2.0 then
                    TriggerServerEvent("oxy:rentVehicle", Config.RentalVehicles[1])
                end
            end
        end

        -- 🚘 **Check Return Locations**
        for _, location in pairs(Config.ReturnLocations) do
            local dist = #(playerCoords - location.coords)
            if dist < 10 then
                sleep = 5
                DrawText3D(location.coords, "[E] Return Vehicle")
                if IsControlJustReleased(0, 38) and dist < 2.0 then
                    returnVehicle()
                end
            end
        end

        -- 🏠 **Check NPC Location (Only Active One)**
        if isMissionActive and currentNPC then
            local dist = #(playerCoords - GetEntityCoords(currentNPC))
            if dist < 10 then
                sleep = 5
                DrawText3D(GetEntityCoords(currentNPC), "[E] Interact")
                if IsControlJustReleased(0, 38) and dist < 2.0 then
                    openNPCMenu()
                end
            end
        end

        Wait(sleep)
    end
end)

-- 🚗 **Spawn the Rental Vehicle**
RegisterNetEvent("oxy:spawnVehicle", function(vehicleModel, price)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)

    QBCore.Functions.SpawnVehicle(vehicleModel, function(veh)
        TaskWarpPedIntoVehicle(playerPed, veh, -1)
        SetEntityHeading(veh, GetEntityHeading(playerPed))

        -- 🔑 **Give Player Vehicle Keys**
        local plate = QBCore.Functions.GetPlate(veh)
        TriggerEvent('vehiclekeys:client:SetOwner', plate)

        -- 💰 Deduct Rental Cost
        TriggerServerEvent("oxy:deductMoney", price)

        currentVehicle = veh
        isMissionActive = true
        QBCore.Functions.Notify("You rented a " .. vehicleModel .. " for $" .. price, "success")

        -- Start the NPC interaction sequence
        spawnNextNPC()
    end, coords, true)
end)

-- 🚘 **Return Vehicle & End Mission**
function returnVehicle()
    if currentVehicle then
        DeleteEntity(currentVehicle)
        currentVehicle = nil

        -- Clean up NPC and waypoint
        cleanupMissionEntities()

        -- Reset mission state
        isMissionActive = false
        npcCount = 0

        TriggerServerEvent("oxy:returnVehicle")
        QBCore.Functions.Notify("Vehicle returned successfully! Mission reset.", "success")
    else
        QBCore.Functions.Notify("You don't have a rented vehicle to return!", "error")
    end
end

-- ❌ **Clean Up NPC, Blip, and Mission State**
function cleanupMissionEntities()
    if currentNPC then
        DeleteEntity(currentNPC)
        currentNPC = nil
    end

    if currentBlip then
        RemoveBlip(currentBlip)
        currentBlip = nil
    end
end

-- 🏢 **Draw 3D Text Function**
function DrawText3D(coords, text)
    local onScreen, x, y = World3dToScreen2d(coords.x, coords.y, coords.z)
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(x, y)
    end
end

-- 📜 **Open NPC Interaction Menu**
function openNPCMenu()
    local interactionText = Config.InteractionTexts[math.random(#Config.InteractionTexts)]
    currentNPCText = interactionText

    exports['qb-menu']:openMenu({
        {
            header = "NPC Interaction",
            isMenuHeader = true
        },
        {
            header = interactionText,
            txt = "The NPC responds...",
            icon = "fas fa-comment-dots"
        },
        {
            header = "🤝 Handshake",
            txt = "Confirm your interaction",
            params = {
                event = "oxy:performHandshake"
            }
        },
        {
            header = "❌ Close",
            txt = "Exit menu",
            params = {
                event = "qb-menu:closeMenu"
            }
        }
    })
end

-- 🚗 **Open Vehicle Rental Menu**
function openVehicleMenu()
    local menuOptions = {
        { header = "🚗 Select a Vehicle", isMenuHeader = true }
    }

    for _, vehicle in pairs(Config.RentalVehicles) do
        table.insert(menuOptions, {
            header = vehicle.name .. " - $" .. vehicle.price,
            params = {
                event = "oxy:rentVehicle",
                args = vehicle
            }
        })
    end

    table.insert(menuOptions, {
        header = "❌ Close",
        params = { event = "qb-menu:closeMenu" }
    })

    exports['qb-menu']:openMenu(menuOptions)
end

-- 🚶 **Spawn NPC Sequentially with Waypoint**
function spawnNextNPC()
    if currentNPC then
        DeleteEntity(currentNPC)
    end

    if npcCount < #Config.NPCLocations then
        npcCount = npcCount + 1
        local location = Config.NPCLocations[npcCount]

        RequestModel(GetHashKey(location.model))
        while not HasModelLoaded(GetHashKey(location.model)) do
            Wait(100)
        end

        currentNPC = CreatePed(4, GetHashKey(location.model), location.coords.x, location.coords.y, location.coords.z, 0.0, false, true)
        SetEntityInvincible(currentNPC, true)
        SetBlockingOfNonTemporaryEvents(currentNPC, true)

        -- 🗺️ **Set Waypoint to NPC Location**
        setNPCWaypoint(location.coords)
    else
        QBCore.Functions.Notify("Mission Complete! Return the vehicle.", "success")
        clearNPCWaypoint() -- Remove waypoint when mission ends
    end
end

-- 🗺️ **Set Waypoint for NPC**
function setNPCWaypoint(coords)
    if currentBlip then
        RemoveBlip(currentBlip)
    end
    currentBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(currentBlip, 280)
    SetBlipColour(currentBlip, 1)
    SetBlipScale(currentBlip, 0.8)
    SetBlipRoute(currentBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Mission NPC")
    EndTextCommandSetBlipName(currentBlip)
end

-- ❌ **Clear NPC Waypoint**
function clearNPCWaypoint()
    if currentBlip then
        RemoveBlip(currentBlip)
        currentBlip = nil
    end
end

-- 🤝 **Perform Handshake Animation & Give Reward**
RegisterNetEvent("oxy:performHandshake", function()
    local playerPed = PlayerPedId()

    RequestAnimDict("mp_ped_interaction")
    while not HasAnimDictLoaded("mp_ped_interaction") do
        Wait(100)
    end

    TaskPlayAnim(playerPed, "mp_ped_interaction", "handshake_guy_a", 8.0, -8.0, 5000, 0, 0, false, false, false)
    TaskPlayAnim(currentNPC, "mp_ped_interaction", "handshake_guy_b", 8.0, -8.0, 5000, 0, 0, false, false, false)

    isHandshaking = true
    QBCore.Functions.Notify("You interacted: " .. currentNPCText, "success")

    Wait(5000)

    ClearPedTasks(playerPed)
    ClearPedTasks(currentNPC)
    DeleteEntity(currentNPC)

    -- 🏆 **Trigger Reward System**
    TriggerServerEvent("oxy:giveReward")

    Wait(10000) -- Wait 10 seconds before spawning next NPC
    spawnNextNPC()
end)
