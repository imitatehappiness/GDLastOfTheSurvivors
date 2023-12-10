extends Area2D

@export var gold = 1

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var sound = $AudioCollected

var sprite_silver = preload("res://resources/textures/Items/Gold/coin_04c.png")
var sprite_gold = preload("res://resources/textures/Items/Gold/coin_04d.png")
var sprite_diamond = preload("res://resources/textures/Items/Gold/coin_04e.png")
var sprite_mountain_of_gold = preload("res://resources/textures/Items/Gold/mountain_of_gold.png")

var target = null
var speed = -1

func _ready():
	if gold < 10:
		sprite.texture = sprite_silver
	elif gold < 25:
		sprite.texture = sprite_gold
	elif gold < 50:
		sprite.texture = sprite_diamond
	else:
		sprite.texture = sprite_mountain_of_gold

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
