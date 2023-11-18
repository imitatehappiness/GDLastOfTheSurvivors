extends Area2D

var level = 1 
var radius = 100
var damage = 5
var knockback_amount = 0

var angle = Vector2.ZERO
var collision_active
@onready var character = get_tree().get_first_node_in_group("character")

@onready var sprite = $AnimatedSprite2D
@onready var animation = $AnimationPlayer
@onready var collision = $CollisionShape2D

@onready var destroy = get_node("%DestroyTimer")


func _ready():
	match level:
		1:
			level = 1 
			radius = 5 * (1 + character.spell_size)
			damage = 1 
		2:
			level = 2 
			radius = 5 * (1 + character.spell_size)
			damage = 3 
		3:
			level = 3 
			radius = 7 * (1 + character.spell_size)
			damage = 6 
		4:
			level = 4 
			radius = 7 * (1 + character.spell_size)
			damage = 10
	
	scale = Vector2(1.0, 1.0) * radius
	destroy.start()
	animation.play("Idle")

func _process(_delta):
	pass
	
func _physics_process(_delta):
	global_position = character.global_position
	
func _on_destroy_timer_timeout():
	queue_free()
