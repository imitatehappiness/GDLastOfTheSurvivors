extends Area2D

var speed: float = 150
var direction = Vector2.RIGHT


func _ready():
	$AnimatedSprite2D.play("default")

func _physics_process(delta):
	position += direction * speed * delta
	rotate(deg_to_rad(90) * delta * 3)

func _on_timer_timeout():
	queue_free()
