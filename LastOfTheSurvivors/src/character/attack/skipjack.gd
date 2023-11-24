
extends Area2D

var level = 1
var health = 2
var speed = 200
var damage = 5
var attack_size = 1.0 


var target = Vector2.ZERO
var angle = Vector2.ZERO
var last_position = Vector2.ZERO

@onready var character = get_tree().get_first_node_in_group("character")

signal remove_from_array(object)

func _ready():
	angle = global_position.direction_to(target)
	rotation = angle.angle() + deg_to_rad(135)
	match level:
		1:
			speed = 200
			damage = 5
			attack_size = 1.0 * (1 + character.spell_size)
			health = 2
		2:
			speed = 200
			damage = 6
			attack_size = 1.0 * (1 + character.spell_size)
			health = 3
		3:
			speed = 200
			damage = 7
			attack_size = 1.0 * (1 + character.spell_size)
			health = 4
		4:
			speed = 200
			damage = 8
			attack_size = 1.0 * (1 + character.spell_size)
			health = 5
	
	
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1)*attack_size, 1).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
	$AnimationPlayer.play("Idle")

func _physics_process(delta):
	position += angle * speed * delta
	
func enemy_hit(charge = 1):
	$HitSound.play()
	health -= charge
	if health <= 0:
		emit_signal("remove_from_array", self)
		queue_free()
	else:
		angle = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()

func _on_timer_timeout():
	emit_signal("remove_from_array", self)
	queue_free()
