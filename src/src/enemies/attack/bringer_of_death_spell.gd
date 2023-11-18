extends Area2D

var damage = 5 
var attack_size = 1.0 

@onready var character = get_tree().get_first_node_in_group("character")

func _ready():
	$HitBox.damage = damage
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1)*attack_size, 1).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
	$AnimationPlayer.play("Attack")
	await $AnimationPlayer.animation_finished
	queue_free()

