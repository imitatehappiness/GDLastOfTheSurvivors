# Класс "ice_spear" представляет собой объект, который представляет ледяное оружие в игре.
extends Area2D

var level = 1 
var speed = 120 
var damage = 1
var finish_radius = 2
var orbit_radius = 100
var orbit_speed = 3.0 
var health = 1
@onready var character = get_tree().get_first_node_in_group("character")
@onready var collision = $CollisionShape2D

var direction 
var angle = 0.0

var atk = true

func _ready():

	match level:
		1:
			speed = 120 
			damage = 2
			finish_radius = 0.7 * (1 + character.spell_size)
			orbit_radius = 100
			orbit_speed = 3.0 
			health = 5
		2:
			speed = 120
			damage = 4
			finish_radius = 1 * (1 + character.spell_size)
			orbit_radius = 100
			orbit_speed = 3.0
			health = 8
		3:
			speed = 120
			damage = 6
			finish_radius = 1.2 * (1 + character.spell_size)
			orbit_radius = 100
			orbit_speed = 3.0
			health = 10
		4:
			speed = 120
			damage = 8
			finish_radius = 1.4 * (1 + character.spell_size)
			orbit_radius = 100
			orbit_speed = 3.0 
			health = 15
	
	global_position = character.global_position + Vector2(10 * character.transform_adjustment.scale.x, 0)
	#direction = character.transform_adjustment.scale
	
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1 * character.transform_adjustment.scale.x, 1)*finish_radius, 2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()

	$AnimationPlayer.play("Idle")

func _physics_process(delta):
	#position.x += speed * delta * direction
	angle += orbit_speed * delta  # Увеличиваем угол в соответствии с скоростью вращения

	# Вычисляем новую позицию снаряда на основе угла и радиуса
	var new_x = character.global_position.x + cos(angle) * orbit_radius
	var new_y = character.global_position.y + sin(angle) * orbit_radius

	global_position = Vector2(new_x, new_y)

func enemy_hit(charge = 1):
	health -= charge
	if health <= 0:
		$AnimationPlayer.play("Finish")
		await  $AnimationPlayer.animation_finished
		queue_free()
		
func _on_timer_timeout():
	$AnimationPlayer.play("Finish")
	await  $AnimationPlayer.animation_finished
	queue_free()
