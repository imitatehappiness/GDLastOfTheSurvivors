
extends Area2D

var level = 1
var speed = 200
var damage = 5
var attack_size = 1.0 

var tail_queue : Array
var tail_lenght = 100

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
			speed = 300
			damage = 5
			attack_size = 1.0 * (1 + character.spell_size)
		2:
			speed = 300
			damage = 6
			attack_size = 1.0 * (1 + character.spell_size)
		3:
			speed = 350
			damage = 7
			attack_size = 1.0 * (1 + character.spell_size)
		4:
			speed = 350
			damage = 8
			attack_size = 1.0 * (1 + character.spell_size)

	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1)*attack_size, 1).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
	$AnimationPlayer.play("Idle")

func _physics_process(delta):
	var screen_size = character.get_viewport_rect().size

	if position.x >= character.global_position.x + screen_size.x / 2  or position.x <= character.global_position.x - screen_size.x / 2 or position.y >= character.global_position.y + screen_size.y / 2  or position.y <= character.global_position.y - screen_size.y / 2 + 15:
		$HitSound.play()
		angle = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()

	position += angle * speed * delta

	tail_queue.push_front(position)
	if tail_queue.size() > tail_lenght:
		tail_queue.pop_back()
	
	$Line2D.clear_points()
	for point in tail_queue:
		$Line2D.add_point(point)
		


		
func enemy_hit(charge = 1):
	pass

func _on_timer_timeout():
	emit_signal("remove_from_array", self)
	queue_free()
