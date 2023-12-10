extends State

signal death()

var portal = preload("res://src/objects/portal.tscn")
var chest = preload("res://src/objects/chest.tscn")

@onready var world = get_tree().get_first_node_in_group("world")
@onready var loot = get_tree().get_first_node_in_group("loot")

func _ready():
	super._ready()
	connect("death", Callable(character, "enemy_death"))

func enter():
	super.enter()
	animation_player.play("Death")
	await animation_player.animation_finished
	emit_signal("death", "boss")
	spawn_portal()
	spawn_chest()
	owner.queue_free()

func spawn_portal():
	var new_portal = portal.instantiate()
	new_portal.position = owner.position
	world.call_deferred("add_child", new_portal)

func spawn_chest():
	var new_chest = chest.instantiate()
	new_chest.position = owner.position
	new_chest.position.x -= 100
	new_chest.gold_reward = owner.coins
	loot.call_deferred("add_child", new_chest)
