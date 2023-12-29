extends State

func _ready():
	super._ready()

func enter():
	super.enter()
	attack()

func attack():
	# ice_spear
	if owner.ice_spear_level > 0:
		owner.ice_spear_timer.wait_time = owner.ice_spear_attack_speed * (1 - owner.spell_cooldown)
		if owner.ice_spear_timer.is_stopped():
			owner.ice_spear_timer.start()

	# tornado	
	if owner.tornado_level > 0:
		owner.tornado_timer.wait_time = owner.tornado_attack_speed * (1 - owner.spell_cooldown)
		if owner.tornado_timer.is_stopped():
			owner.tornado_timer.start()

	# splash_level
	if owner.splash_level > 0:
		owner.splash_timer.wait_time = owner.splash_attack_speed * (1 - owner.spell_cooldown)
		if owner.splash_timer.is_stopped():
			owner.splash_timer.start()
	
	# skipjack
	if owner.skipjack_level > 0:
		owner.skipjack_timer.wait_time = owner.skipjack_attack_speed * (1 - owner.spell_cooldown)
		if owner.skipjack_timer.is_stopped():
			owner.skipjack_timer.start()
	
	# boomerang
	if owner.boomerang_level > 0:
		owner.boomerang_timer.wait_time = owner.boomerang_attack_speed * (1 - owner.spell_cooldown)
		if owner.boomerang_timer.is_stopped():
			owner.boomerang_timer.start()

	# bang_sheep
	if owner.bang_sheep_level > 0:
		owner.bang_sheep_timer.wait_time = owner.bang_sheep_attack_speed * (1 - owner.spell_cooldown)
		if owner.bang_sheep_timer.is_stopped():
			owner.bang_sheep_timer.start()
			
	# trap
	if owner.trap_level > 0:
		owner.trap_timer.wait_time = owner.trap_attack_speed * (1 - owner.spell_cooldown)
		if owner.trap_timer.is_stopped():
			owner.trap_timer.start()
			
	if owner.invulnerability_level > 0 and !owner.invulnerability:
		owner.invulnerability_timer.wait_time = owner.invulnerability_reload * (1 - owner.spell_cooldown)
		if owner.invulnerability_timer.is_stopped():
			owner.invulnerability_timer.start()
