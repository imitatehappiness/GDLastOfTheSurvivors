extends Area2D

var level = 1 
var speed = 150
var back_speed = speed + 200
var damage = 5
var attack_size = 1.0

var target = Vector2.ZERO 
var angle = Vector2.ZERO
var character_position = Vector2.ZERO
var is_back = false

@onready var character = get_tree().get_first_node_in_group("character")

signal remove_from_array(object)

func _ready():
	angle = global_position.direction_to(target)
	#rotation = angle.angle() + deg_to_rad(135)
	match level:
		1:
			speed = 150
			damage = 3
			attack_size = 1.0 * (1 + character.spell_size)
		2:
			speed = 150
			damage = 5
			attack_size = 1.0 * (1 + character.spell_size)
		3:
			speed = 150
			damage = 8
			attack_size = 1.0 * (1 + character.spell_size)
		4:
			speed = 150
			damage = 10
			attack_size = 1.0 * (1 + character.spell_size)
	
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1)*attack_size, 1).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
	$AnimationPlayer.play("Idle")

func _physics_process(delta):
	var distance_to_character = global_position.distance_to(character.global_position)
	print(distance_to_character)
	if distance_to_character > 250:
		is_back = true
		speed = back_speed

	if is_back:
		angle = global_position.direction_to(character.global_position)
	
	position += angle * speed * delta
	
	if distance_to_character <= 5 and is_back:
		emit_signal("remove_from_array", self)
		queue_free()

func enemy_hit(charge = 1):
	pass
