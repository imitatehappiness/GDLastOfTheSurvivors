
extends Area2D

var damage = 20 

var target = Vector2.ZERO 
var angle = Vector2.ZERO 

func _ready():
	angle = global_position.direction_to(target)
	rotation = angle.angle()
	var tween = create_tween()

	tween.play()
	$AnimationPlayer.play("Idle")

func _physics_process(delta):
	pass

func free():
	queue_free()
