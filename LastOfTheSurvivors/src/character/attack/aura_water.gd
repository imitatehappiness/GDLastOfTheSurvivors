extends Area2D

var level = 1 
var radius = 100
var damage = 5

@onready var character = get_tree().get_first_node_in_group("character")

@onready var sprite = $AnimatedSprite2D
@onready var animation = $AnimationPlayer
@onready var collision = $CollisionShape2D


func _ready():
	match level:
		1:
			level = 1 
			radius = 3 * (1 + character.spell_size)
			damage = 1 
		2:
			level = 2 
			radius = 3 * (1 + character.spell_size)
			damage = 3 
		3:
			level = 3 
			radius = 5 * (1 + character.spell_size)
			damage = 5 
		4:
			level = 4 
			radius = 5 * (1 + character.spell_size)
			damage = 7
	
	scale = Vector2(1.0, 1.0) * radius
	animation.play("Idle")

func _process(_delta):
	pass
	
func _physics_process(_delta):
	global_position = character.global_position
