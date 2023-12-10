extends Area2D

signal victory()
@onready var character = get_tree().get_first_node_in_group("character")

func _ready():
	connect("victory", Callable(character, "victory"))
	$AnimationPlayer.play("Default")

func _on_body_entered(body):
	$AnimationPlayer.play("Сlosing")
	character.visible = false
	await $AnimationPlayer.animation_finished

func send_victory():
	emit_signal("victory")
