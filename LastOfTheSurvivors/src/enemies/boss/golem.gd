extends CharacterBody2D

# Paran
@export var movement_speed : float = 40.0
@export var max_health : int = 8000
@export var damage : int = 10
@export var experience : int = 1000
@export var gold : int = 1000
@export var laser_damage : int = 30
@export var bullet_damage : int = 15
@export var hell_bullet_damage : int = 15

@export_group("internal Nodes")
@export var transform_adjustment: Node2D

@onready var character = get_tree().get_first_node_in_group("character")
@onready var sprites = $TransformAdjustment/AnimatedSprite2D
@onready var animation = $TransformAdjustment/AnimationPlayer
@onready var progress_bar = %HealthBar
@onready var get_damage_label = %DamageLabel
@onready var hell_bullet_attack_timer = %HellBulletAttackTimer

var direction : Vector2
var armor = 0
var armor_boost = 5

var phase_2 : bool = false

var health = 100:
	set(value):
		health = value
		progress_bar.max_value = max_health
		progress_bar.value = health
		
		if value <= 0:
			progress_bar.visible = false
			find_child("FiniteStateMachine").change_state("Death")
		elif value <= progress_bar.max_value / 2 and armor == 0:
			armor = 5
			phase_2 = true
			find_child("FiniteStateMachine").change_state("ArmorBuff")

func _ready():
	init()
	set_physics_process(false)

func init():
	health = max_health
	$Pivot/LaserAttack.damage = laser_damage
	$HitBox.damage = damage

func _process(delta):
	direction = character.position - position
	set_character_facing_direction(direction)

func _physics_process(delta):
	velocity = direction.normalized() * movement_speed
	move_and_collide(velocity * delta)

func set_character_facing_direction(direction: Vector2):
	var scale_x = sign(direction.x)
	if scale_x != 0 and abs(global_position.distance_to(character.global_position)) > 10:
		transform_adjustment.scale.x = scale_x

func _on_hurt_box_hurt(damage, _angle, _knockback_amount):
	get_damage_label.text = str(damage)
	get_damage_label.modulate.a = 255
	health -= max(damage,armor) - min(damage,armor)
	var tween = get_damage_label.create_tween()
	tween.tween_property(get_damage_label, "modulate:a", 0, 0.4).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
