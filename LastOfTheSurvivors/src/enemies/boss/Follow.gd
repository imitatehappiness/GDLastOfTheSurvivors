extends State

func enter():
	super.enter()
	owner.set_physics_process(true)
	animation_player.play("Idle")
	
func exit():
	super.exit()
	owner.set_physics_process(false)
	
func transition():
	var distance = owner.direction.length()
	
	if distance < 30:
		get_parent().change_state("MeleeAttack")
	elif distance > 50:
		var chance = randi() % 4
		if owner.phase_2:
			chance = randi() % 4
		else:
			chance = randi() % 2
		match chance:
			0:
				get_parent().change_state("HomingMissile")
			1:
				get_parent().change_state("LaserBeam")
			2:
				get_parent().change_state("CircularAttack")
			3:
				get_parent().change_state("HellBulletAttack")
	
