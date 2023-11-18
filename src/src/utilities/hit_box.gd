extends Area2D

@export var damage = 1

@onready var collision = $CollisionShape2D
@onready var disable_timer = $DisableTimer

func _ready():
	pass

func tempdisabled():
	set_collision_disabled(true)
	disable_timer.start()

func _on_disable_timer_timeout():
	set_collision_disabled(false)

func set_collision_disabled(value):
	collision.call_deferred("set", "disabled", value)

