extends Node

const ICON_PATH = "res://resources/textures/Items/Store/"

const ITEMS = {
	# =========================================================== Health
	"STORE_ITEM_0_1": {
		"name": "Health",
		"level": "1",
		"description": "+ 10 to the initial health",
		"cost": "100",
		"icon_path": ICON_PATH + "health.png"
	},
	"STORE_ITEM_0_2": {
		"name": "Health",
		"level": "2",
		"description": "+ 10 to the initial health",
		"cost": "200",
		"icon_path": ICON_PATH + "health.png"
	},
	"STORE_ITEM_0_3": {
		"name": "Health",
		"level": "3",
		"description": "+ 10 to the initial health",
		"cost": "300",
		"icon_path": ICON_PATH + "health.png"
	},
	"STORE_ITEM_0_4": {
		"name": "Health",
		"level": "4",
		"description": "+ 10 to the initial health",
		"cost": "400",
		"icon_path": ICON_PATH + "health.png"
	},
	"STORE_ITEM_0_5": {
		"name": "Health",
		"level": "5",
		"description": "+ 10 to the initial health",
		"cost": "500",
		"icon_path": ICON_PATH + "health.png"
	},
	"STORE_ITEM_0_MAX": {
		"name": "Health",
		"level": "MAX",
		"description": "Total +50 health",
		"cost": "",
		"icon_path": ICON_PATH + "health.png"
	},
	# =========================================================== Armor
	"STORE_ITEM_1_1": {
		"name": "Shiled",
		"level": "1",
		"description": "+ 0.5 to the initial armor",
		"cost": "100",
		"icon_path": ICON_PATH + "shield1.png"
	},
	"STORE_ITEM_1_2": {
		"name": "Shiled",
		"level": "2",
		"description": "+ 0.5 to the initial armor",
		"cost": "200",
		"icon_path": ICON_PATH + "shield2.png"
	},
	"STORE_ITEM_1_3": {
		"name": "Shiled",
		"level": "3",
		"description": "+ 1 to the initial armor",
		"cost": "300",
		"icon_path": ICON_PATH + "shield3.png"
	},
	"STORE_ITEM_1_4": {
		"name": "Shiled",
		"level": "4",
		"description": "+ 1 to the initial armor",
		"cost": "400",
		"icon_path": ICON_PATH + "shield4.png"
	},
	"STORE_ITEM_1_5": {
		"name": "Shiled",
		"level": "5",
		"description": "+ 1 to the initial armor",
		"cost": "500",
		"icon_path": ICON_PATH + "shield5.png"
	},
	"STORE_ITEM_1_MAX": {
		"name": "Shiled",
		"level": "MAX",
		"description": "Total +4 armor",
		"cost": "",
		"icon_path": ICON_PATH + "shield5.png"
	},
	# =========================================================== Speed
	"STORE_ITEM_2_1": {
		"name": "Speed",
		"level": "1",
		"description": "+ 10 to the initial speed",
		"cost": "100",
		"icon_path": ICON_PATH + "speed.png"
	},
	"STORE_ITEM_2_2": {
		"name": "Speed",
		"level": "2",
		"description": "+ 10 to the initial speedr",
		"cost": "200",
		"icon_path": ICON_PATH + "speed.png"
	},
	"STORE_ITEM_2_3": {
		"name": "Speed",
		"level": "3",
		"description": "+ 10 to the initial speed",
		"cost": "300",
		"icon_path": ICON_PATH + "speed.png"
	},
	"STORE_ITEM_2_4": {
		"name": "Speed",
		"level": "4",
		"description": "+ 10 to the initial speed",
		"cost": "400",
		"icon_path": ICON_PATH + "speed.png"
	},
	"STORE_ITEM_2_5": {
		"name": "Speed",
		"level": "5",
		"description": "+ 10 to the initial speed",
		"cost": "500",
		"icon_path": ICON_PATH + "speed.png"
	},
	"STORE_ITEM_2_MAX": {
		"name": "Speed",
		"level": "MAX",
		"description": "Total +50 to the initial speed",
		"cost": "",
		"icon_path": ICON_PATH + "speed.png"
	},
	# =========================================================== double splash
	"STORE_ITEM_3_1": {
		"name": "Double splash",
		"level": "1",
		"description": "Adds a second wave behind the character",
		"cost": "1000",
		"icon_path": ICON_PATH + "double_splash.png"
	},
	"STORE_ITEM_3_MAX": {
		"name": "Double splash",
		"level": "MAX",
		"description": "Adds a second wave behind the character",
		"cost": "",
		"icon_path": ICON_PATH + "double_splash.png"
	},
	# =========================================================== Respawn
	"STORE_ITEM_10_1": {
		"name": "Respawn",
		"level": "1",
		"description": "After death, the character is resurrected with half a life once per game",
		"cost": "10000",
		"icon_path": ICON_PATH + "respawn.png"
	},
	"STORE_ITEM_10_MAX": {
		"name": "Respawn",
		"level": "MAX",
		"description": "After death, the character is resurrected with half a life once per game",
		"cost": "",
		"icon_path": ICON_PATH + "respawn.png"
	},
}
