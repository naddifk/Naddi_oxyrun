🚀 Oxy Run Script for QBCore
This script is a fully structured and optimized oxy run mission system designed for FiveM using the QBCore Framework.

Features Included:
✅ Vehicle Rental & Return System (With 3D Text Prompts & Automatic Key Assignment)
✅ Dynamic NPC Interactions (Friendly, Neutral, Aggressive Reactions)
✅ Waypoint & Navigation System
✅ Mission Cooldowns & Anti-Abuse Mechanisms
✅ Police Alerts, Random Chases & Bribery System
✅ Item Rewards Based on Chance
✅ Fully Optimized for Performance & Server Stability

📂 File Structure
arduino
Copy
Edit
qb-oxy-run/
│── fxmanifest.lua
│── config.lua
│── server.lua
│── client.lua
│── locales/
│   ├── en.lua
│── README.md
📌 Installation Guide
✅ 1. Download & Place the Script
Download or clone this repository.
Place the qb-oxy-run folder inside your resources/[qb] directory.
✅ 2. Add to server.cfg
Add the following line to your server.cfg:

ini
Copy
Edit
ensure qb-oxy-run
✅ 3. Restart Your Server
Restart your FiveM server to load the script.

📌 Configuration
The script is fully configurable via config.lua.
Modify settings such as:

Rental & Return Locations
NPC Locations & Reactions
Mission Rewards & Item Drop Rates
Police Alert & Bribery Mechanics
Cooldowns & Player Progression
📌 Dependencies
This script requires the following resources:

ini
Copy
Edit
qb-core
qb-target
qb-menu
qb-vehiclekeys
Ensure they are installed and running on your server.

📌 Commands
Command	Description
/returnoxy	Returns the rented vehicle and ends the mission.
/canceloxy	Cancels the current oxy run mission.
/startoxy	Manually starts an oxy run mission.
📌 How It Works
1️⃣ Players visit a rental location and press {E} to rent a vehicle.
2️⃣ A vehicle is spawned, and the player automatically receives the key.
3️⃣ A waypoint is set for the first NPC location.
4️⃣ Players follow the waypoint and interact with the NPC.
5️⃣ NPC interaction displays a menu (Friendly, Neutral, or Aggressive NPCs).
6️⃣ After selecting interaction type, NPCs may react differently:

Handshake: Confirms the transaction.
Bribery: Reduces the chance of police alerts.
Threats: Might alert the police!
7️⃣ The mission continues until all NPC interactions are completed.
8️⃣ Returning the vehicle ends the mission and resets progress.
📌 NPC Interaction System
Each NPC has a random reaction type:

Friendly NPCs: Engage in a normal handshake.
Neutral NPCs: Can be bribed to reduce police alert risk.
Aggressive NPCs: Might call the police if threatened!
When interacting, NPCs randomly pick a dialogue from a predefined list.

📌 Reward System
Cash Rewards: Based on mission completion time.
Item Rewards: Dropped based on a percentage chance.
Bribery System: Players can pay NPCs to reduce the chance of police alerts.
📜 Example of Item Reward Drop Rates:

lua
Copy
Edit
Config.RewardItems = {
    {name = "oxy", chance = 40},  -- 40% chance
    {name = "weed_bag", chance = 30},  -- 30% chance
    {name = "lockpick", chance = 15},  -- 15% chance
    {name = "coke_bag", chance = 10},  -- 10% chance
    {name = "bandage", chance = 5}  -- 5% chance
}
📌 Police & Chase System
🚔 If the police alert is triggered:

A random chance determines if a chase starts.
If a chase is triggered, AI police will spawn and pursue the player.
Players can escape or be caught by law enforcement!
📌 Future Enhancements
✅ Gang Affiliations Affect NPC Reactions
✅ Hidden Missions Unlocked Through Bribery
✅ A "Most Wanted" System for Aggressive Players

📌 Final Notes
This script is fully optimized for performance & scalability.
All interactions & events are dynamically handled for a smooth experience.
Easily customizable to fit any server's economy & roleplay mechanics.
