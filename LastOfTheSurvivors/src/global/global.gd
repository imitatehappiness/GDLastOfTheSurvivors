
extends Node

signal purchase()

const character_data_path = "res://character_data.json"

var character_data = {}

func _ready():
	load_character_data()

func load_character_data():
	var character_data_file = FileAccess.open(character_data_path, FileAccess.READ)
	if not character_data_file:
		create_default_character_data()
		save_character_data()
	var json = JSON.new()

	if json.parse(character_data_file.get_as_text()) != OK:
		print("Error: Failed to parse JSON from character_data")
		json.close()
		return

	character_data_file.close()
	character_data = json.get_data()
	print(character_data)

func save_character_data():
	var character_data_file = FileAccess.open(character_data_path, FileAccess.WRITE)
	if not character_data_file:
		print("Error: Unable to open character_data_file for writing.")
		return
	var json_string = JSON.stringify(character_data, "", false)
	character_data_file.store_string(json_string)
	character_data_file.close()

func create_default_character_data():
	character_data = {
		"GOLD": {"gold": 0},
		"CHARACTER_STORE_UPGRADES": {
			"health": 0,
			"shield": 0.5,
			"respawn": 0,
			"double_splash": 0,
			"speed": 0,
			"spell_cooldown": 0,
			"spell_size": 0.05
		}
	}
