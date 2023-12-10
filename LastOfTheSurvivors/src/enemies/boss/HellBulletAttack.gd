extends State

@export var bullet_node : PackedScene
var can_transition: bool = false

var theta: float = 0.0
var alpha_values: Array = [0.5, 1.2]
var alpha: float 

func enter():
	super.enter()
	alpha = alpha_values[randi() % alpha_values.size()]
	animation_player.play("Hell_bullet_attack")
	await animation_player.animation_finished
	can_transition = true

func shoot():
	var bullet = bullet_node.instantiate()
	bullet.position = owner.global_position
	bullet.direction = get_vector(theta)
	bullet.damage = owner.hell_bullet_damage
	get_tree().current_scene.call_deferred("add_child", bullet)
	
func transition():
	if can_transition:
		can_transition = false
		get_parent().change_state("Dash")

func get_vector(angle):
	theta = angle + alpha
	return Vector2(cos(theta), sin(theta))

func _on_hell_bullet_attack_timer_timeout():
	shoot()
