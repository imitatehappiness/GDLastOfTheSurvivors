extends Area2D

var level = 1 
var damage = 5 
var attack_size = 1.1 
var direction = 1
@onready var character = get_tree().get_first_node_in_group("character")

func _ready():

	match level:
		1:
			damage = 3
			attack_size = 1.1
		2:
			damage = 5
			attack_size = 1.5
		3:
			damage = 8
			attack_size = 1.8
		4:
			damage = 10
			attack_size = 2.2

	global_position = character.global_position + direction * Vector2(50 * character.transform_adjustment.scale.x * attack_size, 0)
	
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1 * character.transform_adjustment.scale.x, 1)*attack_size, 1).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
	
	if direction == -1:
		$AnimatedSprite2D.flip_h = true
		
	$AnimatedSprite2D.play("Idle")

func _on_timer_timeout():
	queue_free()

