extends Area2D


var level = 1
var health = 999 
var speed = 120.0
var damage = 5 
var knockback_amount = 50 
var attack_size = 1.0 

var last_movement = Vector2.ZERO
var angle = Vector2.ZERO
var angle_less = Vector2.ZERO
var angle_more = Vector2.ZERO

@onready var character = get_tree().get_first_node_in_group("character")

signal remove_from_array(object)

func _ready():
	match level:
		1:
			health = 999 
			speed = 120.0
			damage = 5
			attack_size = 1.0 * (1 + character.spell_size)
		2:
			health = 999 
			speed = 120.0
			damage = 6
			attack_size = 1.0 * (1 + character.spell_size)
		3:
			health = 999 
			speed = 120.0
			damage = 8
			attack_size = 1.0 * (1 + character.spell_size)
		4:
			health = 999 
			speed = 120.0
			damage = 10
			attack_size = 1.0 * (1 + character.spell_size)
			
	angle = last_movement
	$AnimationPlayer.play("Idle")


func _physics_process(delta):
	position -= angle * speed * delta
	
func enemy_hit(_charge):
	pass

func _on_timer_timeout():
	emit_signal("remove_from_array", self)
	queue_free()
