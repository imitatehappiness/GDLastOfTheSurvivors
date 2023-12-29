extends Node

signal purchase()

var store_data_path = "res://store_data.json"
var store_data = {}

func _ready():
	load_store_data()

func load_store_data():
	var store_data_file = FileAccess.open(store_data_path, FileAccess.READ)
	if not store_data_file:
		create_default_store_data()
		save_store_data()
	var json = JSON.new()

	if json.parse(store_data_file.get_as_text()) != OK:
		print("Error: Failed to parse JSON from store_data")
		json.close()
		return

	store_data_file.close()
	store_data = json.get_data()
	print(store_data)

func save_store_data():
	var store_data_file = FileAccess.open(store_data_path, FileAccess.WRITE)
	
	if not store_data_file:
		print("Error: Unable to open store_data_file for writing.")
		return

	var json_string = JSON.stringify(store_data, "", false)

	store_data_file.store_string(json_string)
	store_data_file.close()

func create_default_store_data():
	store_data = {
		"STORE_ITEM_0": {"level": "1", "max_level": 5},
		"STORE_ITEM_1": {"level": "1", "max_level": 5},
		"STORE_ITEM_2": {"level": "1", "max_level": 5},
		"STORE_ITEM_3": {"level": "1", "max_level": 5},
		"STORE_ITEM_4": {"level": "1", "max_level": 5},
		"STORE_ITEM_9": {"level": "1", "max_level": 1},
		"STORE_ITEM_10": {"level": "1", "max_level": 1}
	}
