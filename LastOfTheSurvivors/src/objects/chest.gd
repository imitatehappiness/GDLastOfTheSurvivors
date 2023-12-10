extends Area2D

@export var gold_reward : int = 10
@export var experience_reward : int = 1

var gem_scene = preload("res://src/objects/experience_gem.tscn")
var gold_scene = preload("res://src/objects/gold.tscn")

@onready var loot_base = get_tree().get_first_node_in_group("loot")

var is_open : bool = false

func _ready():
	$AnimationPlayer.play("Default")

func give_loot():
	var gold = gold_scene.instantiate()
	gold.gold = gold_reward
	gold.global_position = Vector2(global_position.x, global_position.y - 25)
	loot_base.call_deferred("add_child", gold)

func _on_body_entered(body):
	if !is_open:
		is_open = true
		$AnimationPlayer.play("Open")

