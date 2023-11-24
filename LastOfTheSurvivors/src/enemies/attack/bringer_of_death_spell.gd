extends Area2D

var speed = 300
var damage = 20 
var attack_size = 3.0 

var target = Vector2.ZERO 
var angle = Vector2.ZERO 

@onready var free_timer = get_node("%FreeTimer")

func _ready():
	global_position = target
	$HitBox.damage = damage
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1)*attack_size, 1).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
	$AnimationPlayer.play("Attack")
	free_timer.start()


func _physics_process(_delta):
	global_position = target

func _on_timer_timeout():
	$PointLight2D.enabled = false
	queue_free()


func _on_free_timer_timeout():
	pass # Replace with function body.
