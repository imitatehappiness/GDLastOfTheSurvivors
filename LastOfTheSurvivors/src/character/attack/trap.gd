# Класс "ice_spear" представляет собой объект, который представляет ледяное оружие в игре.
extends Area2D

var level = 1
var damage = 5 
var attack_size = 1.0
var attack_time

var target = Vector2.ZERO

@onready var character = get_tree().get_first_node_in_group("character")
@onready var animation = $AnimationPlayer
@onready var collision = $CollisionShape2D
@onready var attack_timer = $Timer

signal remove_from_array(object)

func _ready():
	match level:
		1:
			damage = 3
			attack_size = 1.0 * (1 + character.spell_size)
			attack_time = 1.4
		2:
			damage = 5
			attack_size = 1.0 * (1 + character.spell_size)
			attack_time = 2.4
		3:
			damage = 7
			attack_size = 1.0 * (1 + character.spell_size)
			attack_time = 3.4
		4:
			damage = 9
			attack_size = 1.0 * (1 + character.spell_size)
			attack_time = 4.4
	
	
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1)*attack_size, 1).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
	collision.disabled = true
	
	global_position = character.global_position

	animation.play("Preparation")
	$AttackSound.play()
	await animation.animation_finished
	collision.disabled = false
	animation.play("Attack")
	attack_timer.set_wait_time(attack_time)
	attack_timer.start()

func enemy_hit(charge = 1):
	pass

func _on_timer_timeout():
	queue_free()
