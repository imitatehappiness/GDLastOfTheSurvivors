extends CharacterBody2D

@export var movement_speed = 40.0
@export var max_health = 1000
@export var damage = 3
@export var experience = 1
@export var coins = 3
@export var laser_damage = 30

@export_group("internal Nodes")
@export var transform_adjustment: Node2D

@onready var animation = $TransformAdjustment/AnimationPlayer
@onready var character = get_tree().get_first_node_in_group("character")
@onready var get_damage_label = get_node("%DamageLabel")
@onready var loot_base = get_tree().get_first_node_in_group("loot")
@onready var hit_box = $HitBox

@onready var health_bar = get_node("%HealthBar")

# Hell Bullet
var theta: float = 0.0
var alpha: float = 1

var health

signal remove_from_array(object)

var exp_gem = preload("res://src/objects/experience_gem.tscn")
var gold = preload("res://src/objects/gold.tscn")
var hell_bullet = preload("res://src/enemies/attack/golem_hell_bullet.tscn")

enum {
	IDLE,
	WALK,
	DEATH,
	DAMAGE,
	LASER_ATTACK
}

var state: int = WALK:
	set(value):
		state = value
		match state:
			IDLE:
				idle_state()
			WALK:
				walk_state()
			DEATH:
				death_state()
			DAMAGE: 
				damage_state()
			LASER_ATTACK:
				laser_attack()
				
signal death()

func _ready():
	health = max_health
	$LaserTimer.start()
	connect("death", Callable(character, "enemy_death"))
	hit_box.damage = damage
	state = WALK
	health_bar.max_value = max_health
	health_bar.value = health

func _process(delta):
	if state != LASER_ATTACK:
		if state != DAMAGE:
			state = WALK if velocity.length_squared() > 0 else IDLE

		var direction = global_position.direction_to(character.global_position)
		velocity = direction * movement_speed

		set_character_facing_direction(direction)
		move_and_slide()

func idle_state():
	#animation.play("Idle")
	pass


func walk_state():
	animation.play("Walk")

func death_state():
	var gem_chance = randf()
	if gem_chance <= 0.80:
		var new_gem = exp_gem.instantiate()
		new_gem.global_position = global_position
		new_gem.experience = experience
		loot_base.call_deferred("add_child", new_gem)
	
	var gold_chance = randf()
	if gold_chance <= 0.10:
		var new_gold = gold.instantiate()
		new_gold.gold = coins
		new_gold.global_position = global_position
		new_gold.global_position.y -= 15
		loot_base.call_deferred("add_child", new_gold)
	
	hide()
	set_process(false)
	#queue_free()

func damage_state():
	var tween = get_damage_label.create_tween()
	tween.tween_property(get_damage_label, "modulate:a", 0, 0.4).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()

	if health <= 0:
		$HurtBox/CollisionShape2D.call_deferred("set", "disabled", true)
		$HitBox/CollisionShape2D.call_deferred("set", "disabled", true)
		$CollisionShape2D.call_deferred("set", "disabled", true)
		animation.play("Death")
		await animation.animation_finished
		emit_signal("death", "boss")
		state = DEATH
	else:
		if state != LASER_ATTACK:
			animation.play("Hit")
			await animation.animation_finished
		state = WALK

func set_character_facing_direction(direction: Vector2):
	var scale_x = sign(direction.x)
	if scale_x != 0 and abs(global_position.distance_to(character.global_position)) > 10:
		transform_adjustment.scale.x = scale_x * (-1)

func _on_hurt_box_hurt(damage, _angle, _knockback_amount):
	get_damage_label.text = str(damage)
	get_damage_label.modulate.a = 255
	health -= damage
	health_bar.max_value = max_health
	health_bar.value = health
	state = DAMAGE

func _on_laser_timer_timeout():
	if state != DEATH:
		state = LASER_ATTACK

func laser_attack():

	animation.play("LaserPreparation")
	await animation.animation_finished
	$LaserNode2D.rotation = global_position.direction_to(character.global_position).angle()
	$LaserNode2D/LaserHitBox/AudioStreamPlayer.play()
	$LaserNode2D/LaserAnimation.play("Idle")
	await $LaserNode2D/LaserAnimation.animation_finished

	state = WALK
	$LaserTimer.start()


func get_vector(angle):
	theta = angle + alpha
	return Vector2(cos(theta), sin(theta))
	
func shoot_hell_bullet(angle):
	var bullet = hell_bullet.instantiate()
	bullet.position = global_position
	bullet.direction = get_vector(angle)
	get_tree().current_scene.call_deferred("add_child", bullet)

func _on_speed_timeout():
	shoot_hell_bullet(theta)

func _on_change_alpha_timeout():
	var values = [0.5, 1.5]
	alpha = values[randi() % values.size()]
