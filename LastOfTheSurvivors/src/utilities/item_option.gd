extends ColorRect

@onready var name_label = $NameLabel
@onready var description_label = $DescriptionLabel
@onready var level_label = $LevelLabel
@onready var item_icon = $ItemIcon

var mouse_over = false
var item = null

@onready var character = get_tree().get_first_node_in_group("character")

signal selected_upgrade(upgrade)

func _ready():
	connect("selected_upgrade", Callable(character, "upgrade_character"))
	if item == null:
		item = "food"
	name_label.text = UpgradeDB.UPGRADES[item]["displayname"]
	description_label.text = UpgradeDB.UPGRADES[item]["details"]
	level_label.text = UpgradeDB.UPGRADES[item]["level"]
	item_icon.texture = load(UpgradeDB.UPGRADES[item]["icon"])

func _input(event):
	if event.is_action("click"):
		if mouse_over:

			await get_tree().create_timer(1).timeout
			emit_signal("selected_upgrade", item)


func _on_texture_button_pressed():
	position.y -= -1
	emit_signal("selected_upgrade", item)
	
func _on_texture_button_button_down():
	position.y += 1


func _on_texture_button_button_up():
	position.y -= 1


