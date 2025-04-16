Config = {}

-- 🚗 Rental Locations
Config.RentalLocations = {
    {name = "Downtown Rental", coords = vector3(906.19, -2536.91, 28.3)}
}

-- 🚘 Vehicle Return Locations
Config.ReturnLocations = {
    {name = "Downtown Return", coords = vector3(900.23, -2536.14, 28.29)}
}

-- 🚗 Rental Vehicles
Config.RentalVehicles = {
    { name = "Blista", model = "Blista", price = 750 }
}

-- 🏠 NPC Locations
Config.NPCLocations = {
    {coords = vector3(95.73, -1737.32, 29.29), model = "a_m_m_soucent_04", reaction = "friendly"},
    {coords = vector3(247.56, -1471.9, 29.29), model = "a_f_y_hipster_02", reaction = "neutral"},
    {coords = vector3(58.61, -1048.33, 29.37), model = "a_m_y_skater_01", reaction = "aggressive"},
    {coords = vector3(366.76, -381.44, 46.15), model = "a_f_m_business_02", reaction = "neutral"},
    {coords = vector3(31.89, -125.38, 55.87), model = "a_f_m_fatcult_01", reaction = "friendly"},
    {coords = vector3(-100.25, 151.66, 82.56), model = "a_m_m_soucent_04", reaction = "friendly"},
    {coords = vector3(-391.17, 257.89, 83.52), model = "a_f_y_hipster_02", reaction = "neutral"},
    {coords = vector3(-861.35, 52.74, 50.97), model = "a_m_y_skater_01", reaction = "aggressive"},
    {coords = vector3(-861.35, 52.74, 50.97), model = "a_f_o_soucent_01", reaction = "neutral"},
    {coords = vector3(-960.62, -506.47, 36.98), model = "a_m_y_downtown_01", reaction = "friendly"},
    --- new add 👇👇👇👇👇
    {coords = vector3(-1039.86, -755.01, 19.84), model = "a_f_m_bevhills_01", reaction = "aggressive"},
    {coords = vector3(-1323.5, -888.73, 12.76), model = "a_f_m_bodybuild_01", reaction = "friendly"},
    {coords = vector3(-1347.75, -757.6, 22.44), model = "a_f_m_ktown_02", reaction = "friendly"},
    {coords = vector3(-1081.43, -368.44, 37.13), model = "a_m_y_gay_01", reaction = "friendly"},
    {coords = vector3(-725.1, -423.92, 35.19), model = "a_m_y_juggalo_01", reaction = "friendly"},
    {coords = vector3(-284.31, -601.69, 33.55), model = "a_m_y_motox_02", reaction = "friendly"},
    {coords = vector3(-273.74, -933.74, 31.22), model = "a_m_y_salton_01", reaction = "friendly"},
    {coords = vector3(212.44, -936.63, 24.14), model = "a_m_y_stbla_01", reaction = "friendly"},
    {coords = vector3(471.86, -576.87, 28.5), model = "a_m_y_vinewood_03", reaction = "friendly"},
    {coords = vector3(447.35, -1231.59, 29.97), model = "cs_tanisha", reaction = "friendly"},
    {coords = vector3(488.67, -1469.69, 29.14), model = "csb_anita", reaction = "friendly"},
    {coords = vector3(168.68, -1709.24, 29.29), model = "csb_djblamadon", reaction = "friendly"},
    {coords = vector3(-160.57, -1544.37, 35.08), model = "csb_tonya", reaction = "friendly"},
    {coords = vector3(-330.4, -1320.75, 31.4), model = "ig_lestercrest_2", reaction = "friendly"},
    {coords = vector3(136.13, -1278.67, 29.36), model = "ig_talmm", reaction = "friendly"},
}

-- 🏆 Mission Rewards
Config.RewardBase = 10 
Config.RewardMultiplier = 10 

-- 🎁 **Guaranteed Item Rewards with Amount Range**
Config.RewardItems = {
    {name = "oxy", minAmount = 1, maxAmount = 2},
    {name = "iron", minAmount = 1, maxAmount = 2},
   -- {name = "lockpick", minAmount = 1, maxAmount = 1},
    {name = "dirty_money", minAmount = 1, maxAmount = 120},
    --{name = "bandage", minAmount = 1, maxAmount = 2},
    {name = "acid", minAmount = 1, maxAmount = 2}
}

-- 🚔 Police Configurations
Config.PoliceAlertChance = 30 
Config.PoliceChaseChance = 20 
Config.BribeAmount = 1000 

-- ⏳ Mission Cooldown (Seconds)
Config.MissionCooldown = 300 

-- 🏆 Player Ranking System
Config.EnableRanking = true 

-- 📜 Interaction Texts
Config.InteractionTexts = {
    "Is there any police officer around us?",
    "I think you have to find another job.",
    "You need what?",
    "Have you seen any police officers?",
    "Next time bring me food.",
    "Are you addicted?",
    "Next time bring me a good joke."
}
