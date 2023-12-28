extends Area2D

var level = 1
var speed = 80
var damage = 1
var bang_damage = 5
var attack_size = 1.0

var target = Vector2.ZERO
var angle = Vector2.ZERO

@onready var character = get_tree().get_first_node_in_group("character")

signal remove_from_array(object)

enum {
	IDLE,
	BANG,
	PREPARATION,
}

var state: int = IDLE:
	set(value):
		state = value

func _ready():
	angle = global_position.direction_to(target)
	$AnimatedSprite2D.flip_h = angle.x < 0
	#rotation = angle.angle() + deg_to_rad(135)
	match level:
		1:
			speed = 80
			bang_damage = 2
			attack_size = 1.0 * (1 + character.spell_size)
		2:
			speed = 100
			bang_damage = 4
			attack_size = 1.0 * (1 + character.spell_size)
		3:
			speed = 120
			bang_damage = 6
			attack_size = 1.0 * (1 + character.spell_size)
		4:
			speed = 120
			bang_damage = 9
			attack_size = 1.0 * (1 + character.spell_size)
	
	
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1)*attack_size, 1).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
	$AnimationPlayer.play("Idle")

func _physics_process(delta):
	if state != PREPARATION and state != BANG:
		position += angle * speed * delta

func enemy_hit(charge = 1):
	if state != BANG:
		state = PREPARATION
		$CollisionShape2D2.call_deferred("set", "disabled", true)
		$AnimationPlayer.play("Preparation")
		await $AnimationPlayer.animation_finished

func boost_scale():
	$BangSoundPlay.play()
	state = BANG
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(2.5, 2.5)*attack_size, 0.4).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
	damage = bang_damage
	$BangSoundPlay.play()
	$AnimationPlayer.play("Bang")
	await $AnimationPlayer.animation_finished
	queue_free()


func _on_timer_timeout():
	if state != BANG and state != PREPARATION:
		queue_free() 

