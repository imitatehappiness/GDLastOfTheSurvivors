extends Area2D

var speed = 250
var damage = 20 

var target = Vector2.ZERO 
var angle = Vector2.ZERO 

func _ready():
	$HitBox.damage = damage
	angle = global_position.direction_to(target)
	rotation = angle.angle()
	$AnimatedSprite2D.play("default")

func _physics_process(delta):
	position += angle * speed * delta

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()

func _on_body_entered(body):
	queue_free()
