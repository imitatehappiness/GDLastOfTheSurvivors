extends Node

const ICON_PATH = "res://resources/textures/Items/Upgrades/"
const WEAPON_PATH = "res://resources/textures/Items/Upgrades/"
const UPGRADES = {
	# =========================================================== icespear1
	"icespear1": {
		"icon": WEAPON_PATH + "ice_spear.png",
		"displayname": "Ice Spear",
		"details": "A spear of ice is thrown at a random enemy",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"icespear2": {
		"icon": WEAPON_PATH + "ice_spear.png",
		"displayname": "Ice Spear",
		"details": "Damage +1, health + 1",
		"level": "Level: 2",
		"prerequisite": ["icespear1"],
		"type": "weapon"
	},
	"icespear3": {
		"icon": WEAPON_PATH + "ice_spear.png",
		"displayname": "Ice Spear",
		"details": "Damage +2, health + 1, speed + 50",
		"level": "Level: 3",
		"prerequisite": ["icespear2"],
		"type": "weapon"
	},
	"icespear4": {
		"icon": WEAPON_PATH + "ice_spear.png",
		"displayname": "Ice Spear",
		"details": "Damage +2, health + 1",
		"level": "Level: 4",
		"prerequisite": ["icespear3"],
		"type": "weapon"
	},
	# =========================================================== aura_water
	"aura_water1": {
		"icon": WEAPON_PATH + "aura_water.png",
		"displayname": "Aura Water",
		"details": "The aura of water applying periodic crowns to the area",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"aura_water2": {
		"icon": WEAPON_PATH + "aura_water.png",
		"displayname": "Aura Water",
		"details": "damage + 2",
		"level": "Level: 2",
		"prerequisite": ["aura_water1"],
		"type": "weapon"
	},
	"aura_water3": {
		"icon": WEAPON_PATH + "aura_water.png",
		"displayname": "Aura Water",
		"details": "damage + 3, radius + 2",
		"level": "Level: 3",
		"prerequisite": ["aura_water2"],
		"type": "weapon"
	},
	"aura_water4": {
		"icon": WEAPON_PATH + "aura_water.png",
		"displayname": "Aura Water",
		"details": "damage + 4",
		"level": "Level: 4",
		"prerequisite": ["aura_water3"],
		"type": "weapon"
	},
	# =========================================================== tornado
	"tornado1": {
		"icon": WEAPON_PATH + "tornado.png",
		"displayname": "Tornado",
		"details": "A tornado is created and random heads somewhere in the players direction",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"tornado2": {
		"icon": WEAPON_PATH + "tornado.png",
		"displayname": "Tornado",
		"details": "damage + 1",
		"level": "Level: 2",
		"prerequisite": ["tornado1"],
		"type": "weapon"
	},
	"tornado3": {
		"icon": WEAPON_PATH + "tornado.png",
		"displayname": "Tornado",
		"details": "damage + 2",
		"level": "Level: 3",
		"prerequisite": ["tornado2"],
		"type": "weapon"
	},
	"tornado4": {
		"icon": WEAPON_PATH + "tornado.png",
		"displayname": "Tornado",
		"details": "damage + 2",
		"level": "Level: 4",
		"prerequisite": ["tornado3"],
		"type": "weapon"
	},
	# =========================================================== splash
	"splash1": {
		"icon": WEAPON_PATH + "splash.png",
		"displayname": "Splash",
		"details": "Удар волной перед собой",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"splash2": {
		"icon": WEAPON_PATH + "splash.png",
		"displayname": "Splash",
		"details": "damage + 2, attack_size + 0.1",
		"level": "Level: 2",
		"prerequisite": ["splash1"],
		"type": "weapon"
	},
	"splash3": {
		"icon": WEAPON_PATH + "splash.png",
		"displayname": "Splash",
		"details": "damage + 5, attack_size + 0.1",
		"level": "Level: 3",
		"prerequisite": ["splash2"],
		"type": "weapon"
	},
	"splash4": {
		"icon": WEAPON_PATH + "splash.png",
		"displayname": "Splash",
		"details": "damage + 2, attack_size + 0.1",
		"level": "Level: 4",
		"prerequisite": ["splash3"],
		"type": "weapon"
	},
	# =========================================================== sticky_green_bullet
	"sticky_green_bullet1": {
		"icon": WEAPON_PATH + "slime_green.png",
		"displayname": "Sticky Bullet",
		"details": "It rotates around the character at a certain radius, causing damage to everyone it has touched",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"sticky_green_bullet2": {
		"icon": WEAPON_PATH + "slime_green.png",
		"displayname": "Sticky Bullet",
		"details": "Damage + 2, health + 3, finish_radius + 0.3",
		"level": "Level: 2",
		"prerequisite": ["sticky_green_bullet1"],
		"type": "weapon"
	},
	"sticky_green_bullet3": {
		"icon": WEAPON_PATH + "slime_green.png",
		"displayname": "Sticky Bullet",
		"details": "Damage + 2, health + 2, finish_radius + 0.4",
		"level": "Level: 3",
		"prerequisite": ["sticky_green_bullet2"],
		"type": "weapon"
	},
	"sticky_green_bullet4": {
		"icon": WEAPON_PATH + "slime_green.png",
		"displayname": "Sticky Bullet",
		"details": "Damage + 2, health + 5, finish_radius + 0.4",
		"level": "Level: 4",
		"prerequisite": ["sticky_green_bullet3"],
		"type": "weapon"
	},
	# =========================================================== skipjack
	"skipjack1": {
		"icon": WEAPON_PATH + "skipjack.png",
		"displayname": "Skipjack",
		"details": "Bounces off the enemy and flies in a random direction",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"skipjack2": {
		"icon": WEAPON_PATH + "skipjack.png",
		"displayname": "Skipjack",
		"details": "Damage + 1, health + 1",
		"level": "Level: 2",
		"prerequisite": ["skipjack1"],
		"type": "weapon"
	},
	"skipjack3": {
		"icon": WEAPON_PATH + "skipjack.png",
		"displayname": "Skipjack",
		"details": "Damage + 1, health + 1",
		"level": "Level: 3",
		"prerequisite": ["skipjack2"],
		"type": "weapon"
	},
	"skipjack4": {
		"icon": WEAPON_PATH + "skipjack.png",
		"displayname": "Skipjack",
		"details": "Damage + 1, health + 1",
		"level": "Level: 4",
		"prerequisite": ["skipjack3"],
		"type": "weapon"
	},
	# =========================================================== Boomerang
	"boomerang1": {
		"icon": WEAPON_PATH + "boomerang.png",
		"displayname": "Boomerang",
		"details": "Flies into a random enemy and comes back",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"boomerang2": {
		"icon": WEAPON_PATH + "boomerang.png",
		"displayname": "Boomerang",
		"details": "damage + 2",
		"level": "Level: 2",
		"prerequisite": ["boomerang1"],
		"type": "weapon"
	},
	"boomerang3": {
		"icon": WEAPON_PATH + "boomerang.png",
		"displayname": "Boomerang",
		"details": "damage + 3",
		"level": "Level: 3",
		"prerequisite": ["boomerang2"],
		"type": "weapon"
	},
	"boomerang4": {
		"icon": WEAPON_PATH + "boomerang.png",
		"displayname": "Boomerang",
		"details": "damage + 2",
		"level": "Level: 4",
		"prerequisite": ["boomerang3"],
		"type": "weapon"
	},
	# =========================================================== Trap
	"trap1": {
		"icon": WEAPON_PATH + "trap.png",
		"displayname": "Trap",
		"details": "Appears under the character and explodes after a while",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"trap2": {
		"icon": WEAPON_PATH + "trap.png",
		"displayname": "Trap",
		"details": "damage + 2, attack time + 1",
		"level": "Level: 2",
		"prerequisite": ["trap1"],
		"type": "weapon"
	},
	"trap3": {
		"icon": WEAPON_PATH + "trap.png",
		"displayname": "Trap",
		"details": "damage + 2, attack time + 1",
		"level": "Level: 3",
		"prerequisite": ["trap2"],
		"type": "weapon"
	},
	"trap4": {
		"icon": WEAPON_PATH + "trap.png",
		"displayname": "Trap",
		"details": "damage + 2, attack time + 1",
		"level": "Level: 4",
		"prerequisite": ["trap3"],
		"type": "weapon"
	},
	# =========================================================== armor
	"armor1": {
		"icon": ICON_PATH + "armor_1.png",
		"displayname": "Armor",
		"details": "Reduces Damage + 1",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"armor2": {
		"icon": ICON_PATH + "armor_2.png",
		"displayname": "Armor",
		"details": "Reduces Damage + 1",
		"level": "Level: 2",
		"prerequisite": ["armor1"],
		"type": "upgrade"
	},
	"armor3": {
		"icon": ICON_PATH + "armor_3.png",
		"displayname": "Armor",
		"details": "Reduces Damage + 1",
		"level": "Level: 3",
		"prerequisite": ["armor2"],
		"type": "upgrade"
	},
	"armor4": {
		"icon": ICON_PATH + "armor_4.png",
		"displayname": "Armor",
		"details": "Reduces Damage + 1",
		"level": "Level: 4",
		"prerequisite": ["armor3"],
		"type": "upgrade"
	},
	# =========================================================== speed
	"speed1": {
		"icon": ICON_PATH + "boots_1.png",
		"displayname": "Speed",
		"details": "Movement Speed + 20 per.",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"speed2": {
		"icon": ICON_PATH + "boots_2.png",
		"displayname": "Speed",
		"details": "Movement Speed + 20 per.",
		"level": "Level: 2",
		"prerequisite": ["speed1"],
		"type": "upgrade"
	},
	"speed3": {
		"icon": ICON_PATH + "boots_3.png",
		"displayname": "Speed",
		"details": "Movement Speed + 20 per.",
		"level": "Level: 3",
		"prerequisite": ["speed2"],
		"type": "upgrade"
	},
	"speed4": {
		"icon": ICON_PATH + "boots_4.png",
		"displayname": "Speed",
		"details": "Movement Speed + 20 per.",
		"level": "Level: 4",
		"prerequisite": ["speed3"],
		"type": "upgrade"
	},
	# =========================================================== tome
	"tome1": {
		"icon": ICON_PATH + "book_1.png",
		"displayname": "Tome",
		"details": "Increases the size of spells an additional 10 per. of their base size",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"tome2": {
		"icon": ICON_PATH + "book_2.png",
		"displayname": "Tome",
		"details": "Increases the size of spells an additional 10 per. of their base size",
		"level": "Level: 2",
		"prerequisite": ["tome1"],
		"type": "upgrade"
	},
	"tome3": {
		"icon": ICON_PATH + "book_3.png",
		"displayname": "Tome",
		"details": "Increases the size of spells an additional 10 per. of their base size",
		"level": "Level: 3",
		"prerequisite": ["tome2"],
		"type": "upgrade"
	},
	"tome4": {
		"icon": ICON_PATH + "book_4.png",
		"displayname": "Tome",
		"details": "Increases the size of spells an additional 10 per. of their base size",
		"level": "Level: 4",
		"prerequisite": ["tome3"],
		"type": "upgrade"
	},
	# =========================================================== scroll
	"scroll1": {
		"icon": ICON_PATH + "scroll_1.png",
		"displayname": "Scroll",
		"details": "Decreases of the cooldown of spells + 5 per.",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"scroll2": {
		"icon": ICON_PATH + "scroll_2.png",
		"displayname": "Scroll",
		"details": "Decreases of the cooldown of spells + 5 per.",
		"level": "Level: 2",
		"prerequisite": ["scroll1"],
		"type": "upgrade"
	},
	"scroll3": {
		"icon": ICON_PATH + "scroll_3.png",
		"displayname": "Scroll",
		"details": "Decreases of the cooldown of spells + 5 per.",
		"level": "Level: 3",
		"prerequisite": ["scroll2"],
		"type": "upgrade"
	},
	"scroll4": {
		"icon": ICON_PATH + "scroll_4.png",
		"displayname": "Scroll",
		"details": "Decreases of the cooldown of spells + 5 per.",
		"level": "Level: 4",
		"prerequisite": ["scroll3"],
		"type": "upgrade"
	},
	# =========================================================== ring
	"ring1": {
		"icon": ICON_PATH + "ring_1.png",
		"displayname": "Ring",
		"details": "Additional attack + 1",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"ring2": {
		"icon": ICON_PATH + "ring_2.png",
		"displayname": "Ring",
		"details": "Additional attack + 1",
		"level": "Level: 2",
		"prerequisite": ["ring1"],
		"type": "upgrade"
	},
	"ring3": {
		"icon": ICON_PATH + "ring_3.png",
		"displayname": "Ring",
		"details": "Additional attack + 1",
		"level": "Level: 3",
		"prerequisite": ["ring2"],
		"type": "upgrade"
	},
	"ring4": {
		"icon": ICON_PATH + "ring_4.png",
		"displayname": "Ring",
		"details": "Additional attack + 1",
		"level": "Level: 4",
		"prerequisite": ["ring3"],
		"type": "upgrade"
	},
	# =========================================================== grab area
	"grab_area1": {
		"icon": ICON_PATH + "grab_area_1.png",
		"displayname": "Grab area",
		"details": "+ 17 per.",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"grab_area2": {
		"icon": ICON_PATH + "grab_area_2.png",
		"displayname": "Grab area",
		"details": "+ 17 per.",
		"level": "Level: 2",
		"prerequisite": ["grab_area1"],
		"type": "upgrade"
	},
	"grab_area3": {
		"icon": ICON_PATH + "grab_area_3.png",
		"displayname": "Grab area",
		"details": "+ 17 per.",
		"level": "Level: 3",
		"prerequisite": ["grab_area2"],
		"type": "upgrade"
	},
	"grab_area4": {
		"icon": ICON_PATH + "grab_area_4.png",
		"displayname": "Grab area",
		"details": "+ 17 per.",
		"level": "Level: 4",
		"prerequisite": ["grab_area3"],
		"type": "upgrade"
	},
	# =========================================================== experience multiplier
	"experience_multiplier1": {
		"icon": ICON_PATH + "experience_multiplier_1.png",
		"displayname": "Exp multiplier",
		"details": "+ 10 per.",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"experience_multiplier2": {
		"icon": ICON_PATH + "experience_multiplier_2.png",
		"displayname": "Exp multiplier",
		"details": "+ 10 per.",
		"level": "Level: 2",
		"prerequisite": ["experience_multiplier1"],
		"type": "upgrade"
	},
	"experience_multiplier3": {
		"icon": ICON_PATH + "experience_multiplier_3.png",
		"displayname": "Exp multiplier",
		"details": "+ 10 per.",
		"level": "Level: 3",
		"prerequisite": ["experience_multiplier2"],
		"type": "upgrade"
	},
	"experience_multiplier4": {
		"icon": ICON_PATH + "experience_multiplier_4.png",
		"displayname": "Exp multiplier",
		"details": "+ 10 per.",
		"level": "Level: 4",
		"prerequisite": ["experience_multiplier3"],
		"type": "upgrade"
	},
	# =========================================================== invulnerability
	"invulnerability1": {
		"icon": ICON_PATH + "invulnerability_1.png",
		"displayname": "Invulnerability",
		"details": "The chatacter is invulnerable while active",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"invulnerability2": {
		"icon": ICON_PATH + "invulnerability_1.png",
		"displayname": "Invulnerability",
		"details": "+ 0.2 to invulnerability time",
		"level": "Level: 1",
		"prerequisite": ["invulnerability1"],
		"type": "upgrade"
	},
	"invulnerability3": {
		"icon": ICON_PATH + "invulnerability_1.png",
		"displayname": "Invulnerability",
		"details": "+ 0.2 to invulnerability time",
		"level": "Level: 1",
		"prerequisite": ["invulnerability2"],
		"type": "upgrade"
	},
	"invulnerability4": {
		"icon": ICON_PATH + "invulnerability_1.png",
		"displayname": "Invulnerability",
		"details": "+ 0.2 to invulnerability time",
		"level": "Level: 1",
		"prerequisite": ["invulnerability3"],
		"type": "upgrade"
	},
	# =========================================================== mass_collection
	"mass_collection": {
		"icon": ICON_PATH + "mass_collection.png",
		"displayname": "Mass collection",
		"details": "Collects all the gems on the map",
		"level": "N/A",
		"prerequisite": [],
		"type": "item"
	},
	# =========================================================== food
	"food": {
		"icon": ICON_PATH + "chunk.png",
		"displayname": "Food",
		"details": "Heals you for 20 health",
		"level": "N/A",
		"prerequisite": [],
		"type": "item"
	}
}
