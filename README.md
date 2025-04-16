🚀 Oxy Run Script for QBCore
Oxy Run is a dynamic and immersive script designed for QBCore servers, simulating the thrill and risks of underground pharmaceutical distribution. This script offers a fully configurable experience, integrating seamlessly with your server's economy and roleplay mechanics.

📦 Dependencies
Ensure the following resources are installed and running:

qb-core

qb-target

qb-menu

qb-vehiclekeys

🔧 Installation
Download & Place the Script

Clone or download this repository.

Place the qb-oxy-run folder inside your resources/[qb] directory.

Add to server.cfg

Add the following line to your server.cfg:

arduino
Copy
Edit
ensure qb-oxy-run
Restart Your Server

Restart your FiveM server to load the script.

⚙️ Configuration
Customize the script via config.lua to fit your server's needs:

Locations

Rental & Return Points

NPC Interaction Spots

NPC Behavior

Reaction Types: Friendly, Neutral, Aggressive

Dialogue Variations

Rewards & Items

Cash Rewards Based on Completion Time

Item Drop Rates

Gameplay Mechanics

Mission Cooldowns

Player Progression Tracking

🧑‍💻 Commands

Command	Description
/startoxy	Manually initiates an oxy run mission.
/returnoxy	Returns the rented vehicle and ends the mission.
/canceloxy	Cancels the current oxy run mission.
🎮 Gameplay Overview
Initiation

Players visit a rental location and press {E} to rent a vehicle.

A vehicle is spawned, and the player receives the key.

Mission Progression

A waypoint is set for the first NPC location.

Players interact with NPCs, choosing their approach:

Handshake: Standard transaction.

Bribery: Reduces the chance of police alerts.

Threats: May alert the police!

Completion

After all NPC interactions, returning the vehicle ends the mission and resets progress.

🧠 NPC Interaction System
Each NPC has a randomized reaction type:

Friendly: Engages in a normal handshake.

Neutral: Can be bribed to reduce police alert risk.

Aggressive: Might call the police if threatened!

NPCs select dialogue from a predefined list, adding variety to interactions.

💰 Reward System
Cash Rewards: Based on mission completion time.

Item Rewards: Dropped based on percentage chances.

Example configuration:

lua
Copy
Edit
Config.RewardItems = {
    {name = "oxy", chance = 40},       -- 40% chance
    {name = "weed_bag", chance = 30},  -- 30% chance
    {name = "lockpick", chance = 15},  -- 15% chance
    {name = "coke_bag", chance = 10},  -- 10% chance
    {name = "bandage", chance = 5}     -- 5% chance
}
Bribery System: Players can pay NPCs to reduce the chance of police alerts.

🚓 Police & Chase System
If a police alert is triggered:

A random chance determines if a chase starts.

AI police will spawn and pursue the player.

Players can attempt to escape or risk being caught!

🔮 Future Enhancements
Gang Affiliations: Affect NPC reactions.

Hidden Missions: Unlock through bribery.

"Most Wanted" System: For aggressive players.

📌 Final Notes
Fully optimized for performance and scalability.

All interactions and events are dynamically handled for a smooth experience.

Easily customizable to fit any server's economy and roleplay mechanics.
