extends Area2D


var level = 1 # Уровень 
var health = 999 # Количество целей, которых ледяное копье может поразить
var speed = 100.0# Скорость движения 
var damage = 5 # Количество урона, наносимого целям
var knockback_amount = 50 # Величина отбрасывания целей
var attack_size = 1.0 # Размер атаки 

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
			speed = 100.0
			damage = 5
			knockback_amount = 50
			attack_size = 1.0 * (1 + character.spell_size)
		2:
			health = 999 
			speed = 100.0
			damage = 5
			knockback_amount = 50
			attack_size = 1.0 * (1 + character.spell_size)
		3:
			health = 999 
			speed = 100.0
			damage = 5
			knockback_amount = 50
			attack_size = 1.0 * (1 + character.spell_size)
		4:
			health = 999 
			speed = 100.0
			damage = 5
			knockback_amount = 75
			attack_size = 1.0 * (1 + character.spell_size)
			
	var move_to_less = Vector2.ZERO
	var move_to_more = Vector2.ZERO
	match last_movement:
		Vector2.UP, Vector2.DOWN:
			move_to_less = global_position + Vector2(randf_range(-1, -0.25), last_movement.y) * 500
			move_to_more = global_position + Vector2(randf_range(0.25, 1), last_movement.y) * 500
		Vector2.LEFT, Vector2.RIGHT:
			move_to_less = global_position + Vector2(last_movement.x, randf_range(-1, -0.25)) * 500
			move_to_more = global_position + Vector2(last_movement.x, randf_range(0.25, 1)) * 500
		Vector2(1, 1), Vector2(-1, -1), Vector2(1, -1), Vector2(-1, 1):
			move_to_less = global_position + Vector2(last_movement.x, last_movement.y)
			move_to_more = global_position + Vector2(last_movement.x * + randf_range(0, 0.75), last_movement.y)
			
	angle_less = global_position.direction_to(move_to_less)
	angle_more = global_position.direction_to(move_to_more)
	
	# несколько анимаций одновременно
	var initial_tween = create_tween().set_parallel(true)

	initial_tween.tween_property(self, "scale", scale * 1.2, 3)

	
	var final_speed = speed
	speed = speed / 0.5
	initial_tween.tween_property(self, "speed", final_speed, 6)
	initial_tween.play()
	
	var tween = create_tween()
	var set_angle = randi_range(0, 1)
	if set_angle == 1:
		angle = angle_less
		tween.tween_property(self, "angle", angle_more, 2)
		tween.tween_property(self, "angle", angle_less, 2)
		tween.tween_property(self, "angle", angle_more, 2)
		tween.tween_property(self, "angle", angle_less, 2)
		tween.tween_property(self, "angle", angle_more, 2)
		tween.tween_property(self, "angle", angle_less, 2)
	else:
		angle = angle_more
		tween.tween_property(self, "angle", angle_less, 2)
		tween.tween_property(self, "angle", angle_more, 2)
		tween.tween_property(self, "angle", angle_less, 2)
		tween.tween_property(self, "angle", angle_more, 2)
		tween.tween_property(self, "angle", angle_less, 2)
		tween.tween_property(self, "angle", angle_more, 2)
	tween.play()
	
	$AnimationPlayer.play("Idle")


func _physics_process(delta):
	position += angle * speed * delta
	
func enemy_hit(_charge):
	pass

func _on_timer_timeout():
	emit_signal("remove_from_array", self)
	queue_free()
