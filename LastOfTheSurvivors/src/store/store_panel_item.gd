extends Panel


@export var item_id = "0"

var item = {
	"name": "name",
	"level":  "1",
	"description": "description",
	"cost": "100",
	"icen_path": "",
	"max_level": 5
}

@onready var item_icon_sprite = get_node("%ItemSprite2D")
@onready var name_label = get_node("%NameLabel")
@onready var level_label = get_node("%LevelLabel")
@onready var description_label = get_node("%DescriptionLabel")
@onready var cost_label = get_node("%GoldLabel")

func _ready():
	$BuyTextureButton.set_label_text()
	var title = "STORE_ITEM_" + str(item_id)
	item["level"] = Store.store_data[title]["level"]
	item["max_level"] = Store.store_data[title]["max_level"]
	
	if is_max_level():
		set_upgrade_btn_disabled()

	load_data()
	set_new_data()

func set_new_data():
	name_label.text = item["name"]
	description_label.text = item["description"]
	level_label.text = "level " + item["level"]
	cost_label.text = item["cost"]
	item_icon_sprite.texture = load(item["icon_path"])
	set_tooltip()

func load_data():
	item["level"] = StoreDB.ITEMS["STORE_ITEM_" + item_id + "_" + item["level"]]["level"]
	item["description"] = StoreDB.ITEMS["STORE_ITEM_" + item_id + "_" + item["level"]]["description"]
	item["name"] = StoreDB.ITEMS["STORE_ITEM_" + item_id + "_" + item["level"]]["name"]
	item["cost"] = StoreDB.ITEMS["STORE_ITEM_" + item_id + "_" + item["level"]]["cost"]
	item["icon_path"] =StoreDB.ITEMS["STORE_ITEM_" + item_id + "_" + item["level"]]["icon_path"]

func save_data():
	var title = "STORE_ITEM_" + str(item_id)
	Store.store_data[title]["level"] = item["level"]
	Store.save_store_data()

func is_max_level():
	if item["level"] == "MAX":
		$Cost.visible = false
		return true
	else:
		return false

func upgrade(item_name, item_level):
	match item_name:
		"Health":
			match item_level:
				"1":
					Global.character_data["CHARACTER_STORE_UPGRADES"]["health"] += 10
				"2": 
					Global.character_data["CHARACTER_STORE_UPGRADES"]["health"] += 10
				"3": 
					Global.character_data["CHARACTER_STORE_UPGRADES"]["health"] += 10
				"4": 
					Global.character_data["CHARACTER_STORE_UPGRADES"]["health"] += 10
				"5": 
					Global.character_data["CHARACTER_STORE_UPGRADES"]["health"] += 10
				"MAX":
					pass
		"Shiled":
			match item_level:
				"1":
					Global.character_data["CHARACTER_STORE_UPGRADES"]["shield"] += 0.5
				"2": 
					Global.character_data["CHARACTER_STORE_UPGRADES"]["shield"] += 0.5
				"3": 
					Global.character_data["CHARACTER_STORE_UPGRADES"]["shield"] += 1
				"4": 
					Global.character_data["CHARACTER_STORE_UPGRADES"]["shield"] += 1
				"5": 
					Global.character_data["CHARACTER_STORE_UPGRADES"]["shield"] += 1
				"MAX":
					pass
		"Speed":
			match item_level:
				"1":
					Global.character_data["CHARACTER_STORE_UPGRADES"]["speed"] += 10
				"2": 
					Global.character_data["CHARACTER_STORE_UPGRADES"]["speed"] += 10
				"3": 
					Global.character_data["CHARACTER_STORE_UPGRADES"]["speed"] += 10
				"4": 
					Global.character_data["CHARACTER_STORE_UPGRADES"]["speed"] += 10
				"5": 
					Global.character_data["CHARACTER_STORE_UPGRADES"]["speed"] += 10
				"MAX":
					pass
		"Spell Cooldown":
			match item_level:
				"1":
					Global.character_data["CHARACTER_STORE_UPGRADES"]["spell_cooldown"] += 0.02
				"2": 
					Global.character_data["CHARACTER_STORE_UPGRADES"]["spell_cooldown"] += 0.02
				"3": 
					Global.character_data["CHARACTER_STORE_UPGRADES"]["spell_cooldown"] += 0.02
				"4": 
					Global.character_data["CHARACTER_STORE_UPGRADES"]["spell_cooldown"] += 0.02
				"5": 
					Global.character_data["CHARACTER_STORE_UPGRADES"]["spell_cooldown"] += 0.02
				"MAX":
					pass
		"Spell Size":
			match item_level:
				"1":
					Global.character_data["CHARACTER_STORE_UPGRADES"]["spell_size"] += 0.05
				"2": 
					Global.character_data["CHARACTER_STORE_UPGRADES"]["spell_size"] += 0.05
				"3": 
					Global.character_data["CHARACTER_STORE_UPGRADES"]["spell_size"] += 0.05
				"4": 
					Global.character_data["CHARACTER_STORE_UPGRADES"]["spell_size"] += 0.05
				"5": 
					Global.character_data["CHARACTER_STORE_UPGRADES"]["spell_size"] += 0.05
				"MAX":
					pass
		"Double splash":
			match item_level:
				"1":
					Global.character_data["CHARACTER_STORE_UPGRADES"]["double_splash"] = 1
				"MAX":
					pass
		"Respawn":
			match item_level:
				"1":
					Global.character_data["CHARACTER_STORE_UPGRADES"]["respawn"] = 1
				"MAX":
					pass
	Global.save_character_data()

func set_tooltip():
	var tooltip = ""

	for i in range(int(item["level"]) - 1):
		var key = "STORE_ITEM_" + str(item_id) + "_" + str(i + 1)
		tooltip += "Level " + str(i + 1) + ": " + StoreDB.ITEMS[key]["description"] + "\n"
	$BG.tooltip_text = tooltip

func set_upgrade_btn_disabled(value = true):
	$BuyTextureButton.visible = !value
	$BuyTextureButton.disabled = value
	$BuyTextureButton.set_label_text("")

func _on_buy_texture_button_pressed():
	$BuyTextureButton.position.y -= -1
	var cur_gold = int(Global.character_data["GOLD"]["gold"])
	if cur_gold >= int(item["cost"]):
		cur_gold -=  int(item["cost"])
		upgrade(item["name"], item["level"])
		
		item["level"] = str(int(item["level"]) + 1) if int(item["level"]) + 1 != item["max_level"] + 1 else "MAX"

		if is_max_level():
			set_upgrade_btn_disabled()
		
		save_data()
		load_data()
		set_new_data()
		
		Global.character_data["GOLD"]["gold"] = cur_gold
		Global.save_character_data()
		Global.emit_signal("purchase")
		
		show_information_panel("Upgrade")
	else:
		show_information_panel("Not enough gold")

func show_information_panel(message):
	$InformationPanel.modulate.a = 1.0
	$InformationPanel.visible = true
	$InformationPanel/Label.text = message
	var tween = create_tween()
	tween.connect("finished", _on_information_panel_tween_completed)
	tween.tween_property($InformationPanel, "modulate:a", 0, 0.7)
	tween.play()

func _on_information_panel_tween_completed():
	$InformationPanel.visible = false
