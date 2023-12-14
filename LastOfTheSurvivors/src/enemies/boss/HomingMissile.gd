extends State

@export var bullet_node : PackedScene
var can_transition: bool = false

func enter():
	super.enter()
	animation_player.play("Ranged_attack")
	await animation_player.animation_finished
	shoot()
	can_transition = true

func shoot():
	for i in range(-2, 3):
		var bullet = bullet_node.instantiate()
		bullet.position = owner.position
		bullet.target = character.global_position
		bullet.target.y += i * 50
		bullet.damage = owner.bullet_damage
		get_tree().current_scene.add_child(bullet)
	
func transition():
	if can_transition:
		can_transition = false
		get_parent().change_state("Dash")
