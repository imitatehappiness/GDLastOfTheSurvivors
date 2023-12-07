extends Node

signal purchase()

const config_path_file = "res://config.cfg"
var config = ConfigFile.new()

var gold : int = 0
var version : int = 0

var character_store_upgrades = {
	"health": 0,
	"shield": 0,
	"respawn": 0,
	"double_splash": 0,
	"speed": 0,
	"spell_cooldown": 0,
	"spell_size": 0,
}

func _ready():
	check_config()
	load_data()

func load_data():
	load_character_store_upgrades()
	load_gold()
	load_version()

func save_gold():
	config.load(config_path_file)
	config.set_value("GOLD", "gold", str(gold))
	config.save(config_path_file)

func load_gold():
	config.load(config_path_file)
	gold = int(config.get_value("GOLD", "gold", "-1"))

func load_version():
	config.load(config_path_file)
	version = int(config.get_value("VERSION", "version", "0"))

func get_gold():
	return gold
	
func set_gold(value):
	gold = value

func update_gold(value):
	gold += value

func get_store_item_level(item_id):
	config.load(config_path_file)
	return str(config.get_value("STORE_ITEM_" + item_id, "level", "1"))

func save_store_item_level(item_id, new_level):
	config.set_value("STORE_ITEM_" + item_id, "level", str(new_level))
	config.save(config_path_file)
	
func get_store_item(item_id):
	config.load(config_path_file)

	return {
		"name" : config.get_value("STORE_ITEM_" + item_id, "name", "name"),
		"level" : config.get_value("STORE_ITEM_" + item_id, "level", "1"),
		"description": config.get_value("STORE_ITEM_" + item_id, "description", "description"),
		"icon_path" : config.get_value("STORE_ITEM_" + item_id, "icon_path", ""),
		"cost" : config.get_value("STORE_ITEM_" + item_id, "cost", "10")
	}

func save_store_item(item_id: String, data : Dictionary):
	config.set_value("STORE_ITEM_" + item_id, "name", data["name"])
	config.set_value("STORE_ITEM_" + item_id, "level", data["level"])
	config.set_value("STORE_ITEM_" + item_id, "description", data["description"])
	config.set_value("STORE_ITEM_" + item_id, "cost", data["cost"])
	config.set_value("STORE_ITEM_" + item_id, "icon_path", data["icon_path"])
	config.save(config_path_file)

func load_character_store_upgrades():
	config.load(config_path_file)
	for key in character_store_upgrades.keys():
		character_store_upgrades[key] = config.get_value("CHARACTER_STORE_UPGRADES", key, 0)

func save_character_store_upgrades():
	for key in character_store_upgrades.keys():
		config.set_value("CHARACTER_STORE_UPGRADES", key, character_store_upgrades[key])
	config.save(config_path_file)

func get_character_store_upgrades():
	return character_store_upgrades

func get_store_item_max_level(item_id):
	return int(config.get_value("STORE_ITEM_" + item_id, "max_level", "2"))

# Костыль для экспорта
func check_config():
	config.load(config_path_file)
	gold = int(config.get_value("GOLD", "gold", "-1"))
	if gold == -1: 
		create_config_file()

func create_config_file():
	config.set_value("GOLD", "gold", "300")
	config.set_value("VERSION", "version", "1")
		
	for i in range(5):  # STORE_ITEM_0 до STORE_ITEM_4
		config.set_value( "STORE_ITEM_" + str(i), "level", "1")
		config.set_value( "STORE_ITEM_" + str(i), "max_level", "5")

	config.set_value("STORE_ITEM_9", "level", "1")
	config.set_value( "STORE_ITEM_9", "max_level", "1")

	config.set_value("STORE_ITEM_10", "level", "1")
	config.set_value("STORE_ITEM_10", "max_level", "1")

	config.save(config_path_file)
