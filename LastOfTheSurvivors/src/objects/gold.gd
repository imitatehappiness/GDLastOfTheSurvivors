extends Area2D


@export var gold = 1

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var sound = $AudioCollected

var target = null
var speed = -1

func _ready():
	pass

func _physics_process(delta):
	if target != null:
		global_position = global_position.move_toward(target.global_position, speed)
		speed += 2 * delta


func collect():
	sound.play()
	collision.call_deferred("set", "disabaled", true)
	sprite.visible = false
	return gold

func _on_audio_collected_finished():
	queue_free()