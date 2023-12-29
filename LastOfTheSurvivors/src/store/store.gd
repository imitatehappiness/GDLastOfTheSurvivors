extends Node2D

const menu = "res://src/title_screen/menu.tscn"

var gold
@onready var gold_label = $Gold/GoldLabel

func _ready():
	Global.connect("purchase", Callable(self, "update_gold"))
	update_gold()

func update_gold():
	gold = Global.character_data["GOLD"]["gold"]
	gold_label.text = str(gold)

func set_gold(value):
	gold = value

func _on_back_texture_button_pressed():
	Store.save_store_data()
	get_tree().change_scene_to_file(menu)

