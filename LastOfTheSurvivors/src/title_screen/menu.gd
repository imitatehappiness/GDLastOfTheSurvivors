extends Control

const level = "res://src/world/world.tscn"
const store = "res://src/store/store.tscn"

@onready var animation = $Load/AnimationPlayer
@onready var sprite = $Load/AnimatedSprite2D

func _ready():
	$AudioStreamPlayer.play()

func _on_quit_texture_button_pressed():
	if OS.get_name() == "HTML5":
		print("Quit not supported in HTML5. Please reload the browser tab.")
	else:
		get_tree().quit()

func _on_play_texture_button_pressed():
	$GridContainer/QuitTextureButton.visible = false
	$GridContainer/PlayTextureButton.visible = false
	$GridContainer/StoreTextureButton.visible = false
	sprite.visible = true
	animation.play("Load")
	await animation.animation_finished
	var _level = get_tree().change_scene_to_file(level)
	animation.stop()
	
func _on_store_texture_button_pressed():
	get_tree().change_scene_to_file(store)
	
