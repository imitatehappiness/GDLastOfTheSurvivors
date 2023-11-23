# Класс "ice_spear" представляет собой объект, который представляет ледяное оружие в игре.
extends Area2D

@export var damage = 5
@export var finish_radius = 2
@export var orbit_radius = 110
@export var orbit_speed = 3.0 

@onready var target
@onready var collision = $CollisionShape2D

var direction 
var angle = 0.0

var atk = true

func _ready():
	$AnimationPlayer.play("Idle")

func _physics_process(delta):
	#position.x += speed * delta * direction
	angle += orbit_speed * delta  # Увеличиваем угол в соответствии с скоростью вращения

	# Вычисляем новую позицию снаряда на основе угла и радиуса
	var new_x = target.global_position.x + cos(angle) * orbit_radius
	var new_y = target.global_position.y + sin(angle) * orbit_radius

	global_position = Vector2(new_x, new_y)

func set_target(new_target):
	target = new_target
