extends CharacterBody2D

@export var movement_speed = 50
@export var max_health = 100
@export var damage = 5
@export var sword_damage = 20
@export var experience = 1
@export var spell_damage = 20
@export var spell_scale = 1.0
@export var coins = 20


var health

@export_group("internal Nodes")
@export var transform_adjustment: Node2D

@onready var animation = $TransformAdjustment/AnimationPlayer
@onready var character = get_tree().get_first_node_in_group("character")
@onready var loot_base = get_tree().get_first_node_in_group("loot")

@onready var get_damage_label = get_node("%DamageLabel")
@onready var attack_spell_timer = get_node("%AttackSpellTimer")

signal remove_from_array(object)

var exp_gem = preload("res://src/objects/experience_gem.tscn")
var gold = preload("res://src/objects/gold.tscn")
var spell = preload("res://src/enemies/attack/bringer_of_death_spell.tscn")

enum {
	IDLE,
	WALK,
	DEATH,
	DAMAGE,
	ATTACK,
	SPELL
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

signal death()

func _ready():
	connect("death", Callable(character, "enemy_death"))
	attack_spell_timer.set_wait_time(randi() % 10 + 5)
	attack_spell_timer.start()

	health = max_health
	$HitBox.damage = damage
	$TransformAdjustment/SwordHitBox.damage = sword_damage

func _physics_process(_delta):
	if state != DEATH:
		if state != DAMAGE and state != ATTACK and state != SPELL:
			state = WALK if velocity.x != 0 || velocity.y != 0 else IDLE
		
		var direction =  Vector2(0,0)
		if state != ATTACK and state != SPELL:
			direction = global_position.direction_to(character.global_position)
		
		velocity = direction * movement_speed
		
		set_character_facing_direction(direction)
		move_and_slide()

func idle_state():
	pass
	
func walk_state():
	animation.play("Walk")

func death_state():
	await animation.animation_finished
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
		$HitBox/CollisionShape2D.call_deferred("set", "disabled", true)
		$CollisionShape2D.call_deferred("set", "disabled", true)
		animation.play("Death")
		emit_signal("death")
		state = DEATH
	else:
		if state!=ATTACK and state!=SPELL:
			animation.play("Hit")
			await animation.animation_finished
		state = WALK


func set_character_facing_direction(direction: Vector2):
	var scale_x = sign(direction.x)
	if scale_x != 0:
		if abs(global_position.distance_to(character.global_position)) > 10:
			transform_adjustment.scale.x = scale_x * (-1)


func _on_hurt_box_hurt(damage, _angle, _knockback_amount):
	get_damage_label.text = str(damage)
	get_damage_label.modulate.a = 255
	health -= damage
	if state != ATTACK and state != SPELL:
		state = DAMAGE

func _on_attack_range_body_entered(_body):
	if state != DEATH and state != SPELL:
		animation.play("Attack")
		state = ATTACK
		await animation.animation_finished
		$TransformAdjustment/AttackRange/AttackRangeDisableTimer.start()
		state = WALK
		$TransformAdjustment/SwordHitBox.tempdisabled()


func _on_attack_range_disable_timer_timeout():
	$TransformAdjustment/AttackRange/CollisionShape2D.disabled = true
	$TransformAdjustment/AttackRange/CollisionShape2D.disabled = false

func _on_attack_spell_timer_timeout():
	if state != DEATH:
		velocity = Vector2(0,0)
		state = SPELL
		animation.play("Spell")
		await animation.animation_finished

func init_spell():
	var new_spell = spell.instantiate()
	new_spell.target = character.global_position
	add_child(new_spell)
	attack_spell_timer.start()

func end_spell():
	state = WALK
