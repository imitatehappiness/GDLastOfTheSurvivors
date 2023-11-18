# Класс "ice_spear" представляет собой объект, который представляет ледяное оружие в игре.
extends Area2D

var speed = 300
var damage = 20 
var attack_size = 1.0 


var target = Vector2.ZERO 
var angle = Vector2.ZERO 

func _ready():

	angle = global_position.direction_to(target)
	rotation = angle.angle()
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1)*attack_size, 1).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
	$AnimationPlayer.play("Idle")


func _physics_process(delta):
	position += angle * speed * delta


func _on_timer_timeout():
	queue_free()
