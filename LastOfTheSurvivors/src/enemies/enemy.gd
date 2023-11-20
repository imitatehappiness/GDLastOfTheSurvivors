extends CharacterBody2D

@export var movement_speed = 40.0
@export var health = 10
@export var knockback_recovery = 0.5
@export var damage = 3
@export var experience = 1
@export var coins = 7

var knockback: Vector2 = Vector2.ZERO

@export_group("internal Nodes")
@export var transform_adjustment: Node2D

@onready var animation = $TransformAdjustment/AnimationPlayer
@onready var character = get_tree().get_first_node_in_group("character")
@onready var get_damage_label = get_node("%DamageLabel")
@onready var loot_base = get_tree().get_first_node_in_group("loot")
@onready var hit_box = $HitBox

signal remove_from_array(object)

var exp_gem = preload("res://src/objects/experience_gem.tscn")
var gold = preload("res://src/objects/gold.tscn")

enum {
	IDLE,
	WALK,
	DEATH,
	DAMAGE
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

func _ready():
	hit_box.damage = damage

func _physics_process(_delta):
	knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery)
	
	if state != DAMAGE:
		state = WALK if velocity.x != 0 || velocity.y != 0 else IDLE

	var direction = global_position.direction_to(character.global_position)
	velocity = direction * movement_speed
	velocity += knockback
	
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
	
	queue_free()

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
		state = DEATH
	else:
		animation.play("Hit")
		await animation.animation_finished
		state = WALK

func set_character_facing_direction(direction: Vector2):
	var scale_x = sign(direction.x)
	if scale_x != 0:
		# Проверяем, находится ли враг на безопасном расстоянии от персонажа перед поворотом
		if abs(global_position.distance_to(character.global_position)) > 10:  # Используйте свое расстояние
			transform_adjustment.scale.x = scale_x * (-1)

func _on_hurt_box_hurt(damage, _angle, _knockback_amount):
	get_damage_label.text = str(damage)
	get_damage_label.modulate.a = 255
	health -= damage
	#knockback = angle * knockback_amount
	state = DAMAGE

