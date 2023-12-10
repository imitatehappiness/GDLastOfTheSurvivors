extends State

@export var bullet_node : PackedScene
var can_transition: bool = false

func enter():
	super.enter()
	animation_player.play("Block")
	await animation_player.animation_finished
	shoot()
	can_transition = true

func shoot():
	for i in range(-180, 180, 10):
		var bullet = bullet_node.instantiate()
		bullet.position = owner.position
		bullet.target = character.global_position
		var angle = deg_to_rad(i)
		bullet.angle = Vector2(cos(angle), sin(angle))
		bullet.damage = owner.bullet_damage
		get_tree().current_scene.add_child(bullet)
	
func transition():
	if can_transition:
		can_transition = false
		get_parent().change_state("Dash")
