extends Area2D


@export var experience = 1

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var sound = $AudioCollected

var sprite_green = preload("res://resources/textures/Items/Gems/Gem_green.png")
var sprite_blue = preload("res://resources/textures/Items/Gems/Gem_blue.png")
var sprite_red = preload("res://resources/textures/Items/Gems/Gem_red.png")
var sprite_pink = preload("res://resources/textures/Items/Gems/Gem_pink.png")
var sprite_violet = preload("res://resources/textures/Items/Gems/Gem_violet.png")

var target = null
var speed = -1

func _ready():
	if experience < 5:
		return
	elif experience < 20:
		sprite.texture = sprite_blue
	elif experience < 40:
		sprite.texture = sprite_red
	elif experience < 60:
		sprite.texture = sprite_violet
	else:
		sprite.texture = sprite_pink


func _physics_process(delta):
	if target != null:
		global_position = global_position.move_toward(target.global_position, speed)
		speed += 2 * delta


func collect():
	sound.play()
	collision.call_deferred("set", "disabaled", true)
	sprite.visible = false
	return experience	


func _on_audio_collected_finished():
	queue_free()
