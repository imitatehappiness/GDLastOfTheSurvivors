extends CharacterBody2D

@export_group("internal Nodes")
@export var transform_adjustment: Node2D

@onready var grab_area = get_node("%GrabArea")

@onready var animation_character = $TransformAdjustment/AnimationPlayer

#AttacksNodes
@onready var ice_spear_timer = get_node("%IceSpearTimer")
@onready var ice_spear_attack_timer = get_node("%IceSpearAttackTimer")
@onready var tornado_timer = get_node("%TornadoTimer")
@onready var tornado_attack_timer = get_node("%TornadoAttackTimer")
@onready var aura_water_node = get_node("%AuraWater")
@onready var sticky_green_bulllet_node = get_node("%StickyGreenBullet")
@onready var splash_timer = get_node("%SplashTimer")
@onready var sticky_green_bulllet_timer = get_node("%StickyGreenBulletAttackTimer")
@onready var skipjack_timer = get_node("%SkipjackTimer")
@onready var skipjack_attack_timer = get_node("%SkipjackAttackTimer")
@onready var boomerang_timer = get_node("%BoomerangTimer")
@onready var boomerang_attack_timer = get_node("%BoomerangAttackTimer")
@onready var trap_timer = get_node("%TrapTimer")
@onready var bang_sheep_timer = get_node("%BangSheepTimer")
@onready var bang_sheep_attack_timer = get_node("%BangSheepAttackTimer")
@onready var healing_label = get_node("%HealingLabel")

#UpgradesNodes
@onready var mass_collection_timer = get_node("%MassCollectionTimer")
@onready var invulnerability_timer = get_node("%InvulnerabilityTimer")
@onready var invulnerability_free_timer = get_node("%InvulnerabilityFreeTimer")

#GUI
@onready var experience_bar = get_node("%ExpBar")
@onready var level_label = get_node("%LevelLabel")
@onready var level_panel = get_node("%LevelUpPanel")
@onready var upgrade_options_vbox = get_node("%UpgradeOptions")
@onready var level_up_sound = get_node("%LevelUpSound")
@onready var item_options = preload("res://src/utilities/item_option.tscn")
@onready var stats_label = get_node("%Stats")
@onready var health_bar = get_node("%HealthBar")
@onready var game_time_label = get_node("%Time")

@onready var collected_weapons_grid = get_node("%CollectedWeapons")
@onready var collected_upgrades_grid = get_node("%CollectedUpgrades")
@onready var item_container = preload("res://src/character/gui/item_container.tscn")

@onready var death_panel = get_node("%DeathPanel")
@onready var result_label = get_node("%ResultLabel")
@onready var victory_sound = get_node("%VictorySound")
@onready var lose_sound = get_node("%LoseSound")

@onready var pause_panel = get_node("%PausePanel")


var is_alive = true
var time = 0
var game_time_limit = 60*7

var movement_speed = 90.0 + float(Global.character_data["CHARACTER_STORE_UPGRADES"]["speed"])
var max_health = 50.0 + float(Global.character_data["CHARACTER_STORE_UPGRADES"]["health"])
var last_movement = Vector2.UP
var experience = 0
var experience_level = 1
var collected_experience = 0
var respawn = int(Global.character_data["CHARACTER_STORE_UPGRADES"]["respawn"])
var enemy_death_counter = 0
var gold = 0

#Attacks
var attacks_preload = {
	"ice_spear": preload("res://src/character/attack/ice_spear.tscn"),
	"tornado": preload("res://src/character/attack/tornado.tscn"),
	"aura_water": preload("res://src/character/attack/aura_water.tscn"),
	"splash": preload("res://src/character/attack/splash.tscn"),
	"sticky_green_bullet": preload("res://src/character/attack/sticky_green_bulllet.tscn"),
	"skipjack": preload("res://src/character/attack/skipjack.tscn"),
	"boomerang" : preload("res://src/character/attack/boomerang.tscn"),
	"trap" : preload("res://src/character/attack/trap.tscn"),
	"invulnerability" : preload("res://src/character/attack/invulnerability.tscn"),
	"bang_sheep" : preload("res://src/character/attack/sheep.tscn")
}

#UPGRADES
var collected_upgrades = []
var upgrade_options = []
var armor = 0.0 + float(Global.character_data["CHARACTER_STORE_UPGRADES"]["shield"])

var spell_cooldown = 0.0 + float(Global.character_data["CHARACTER_STORE_UPGRADES"]["spell_cooldown"])
var spell_size = 0.0 + float(Global.character_data["CHARACTER_STORE_UPGRADES"]["spell_size"])
var additional_attack = 0
var grab_area_scale = 0
var experience_multiplier = 1

# vampirism
var vampirism_probability : float = 0
var vampirism_recovery : float = 0

# invulnerability
var invulnerability = false
var invulnerability_time = 1.2
var invulnerability_level = 0
var invulnerability_reload = 5

#IceSpear
var ice_spear_ammo = 0
var ice_spear_base_ammo = 1 
var ice_spear_attack_speed = 2.5
var ice_spear_level = 0

#Tornado
var tornado_ammo = 0
var tornado_base_ammo = 1
var tornado_attack_speed = 2
var tornado_level = 0

#Aura Water
var aura_water_level = 0

#Splash
var splash_level = 1
var splash_attack_speed = 1
var double_splash = int(Global.character_data["CHARACTER_STORE_UPGRADES"]["double_splash"])

# sticky_green_bullet
var sticky_green_bullet_level = 0
var sticky_green_bullet_attack_speed = 4
var sticky_green_bullet_base_ammo = 5
var sticky_green_bullet_ammo = sticky_green_bullet_base_ammo

#Skipjack
var skipjack_ammo = 0
var skipjack_base_ammo = 1 
var skipjack_attack_speed = 6
var skipjack_level = 0

# Boomerang 
var boomerang_ammo = 0
var boomerang_base_ammo = 1 
var boomerang_attack_speed = 4
var boomerang_level = 0

# Bang Sheep
var bang_sheep_ammo = 0
var bang_sheep_base_ammo = 1 
var bang_sheep_attack_speed = 4
var bang_sheep_level = 0

# Trap 
var trap_ammo = 0
var trap_base_ammo = 1 
var trap_attack_speed = 3
var trap_level = 0

#Enemy Related
var enemy_close = []

var health = max_health:
	set(value):
		health = value
		health_bar.max_value = max_health
		health_bar.value = health
		
		if health > max_health:
			health = max_health
		
		if health <= 0:
			if respawn == 1:
				find_child("FiniteStateMachine").change_state("Respawn")
			else:
				find_child("FiniteStateMachine").change_state("Death")

func _ready():
	$"../AudioStreamPlayer".play()
	upgrade_character("splash1")

	find_child("FiniteStateMachine").change_state("Attack")
	set_expbar(experience, calculate_experience_cap())
	_on_hurt_box_hurt(0, 0, 0)

func _physics_process(_delta):
	$GUILayer/GUI/FPSLabel.text = "PFS: " + str(Engine.get_frames_per_second())
	if find_child("FiniteStateMachine").get_current_state() != "Death" and find_child("FiniteStateMachine").get_current_state() != "Win":
		if Input.get_action_strength("pause"):
			find_child("FiniteStateMachine").change_state("Pause")
		movement()
		#if find_child("FiniteStateMachine").get_current_state() != "Damage":
			#movement()
			#if velocity.x != 0 or velocity.y != 0:
				#find_child("FiniteStateMachine").change_state("Walk")
			#else:
				#find_child("FiniteStateMachine").change_state("Idle")
		

# Обрабатывает движение персонажа в зависимости от ввода игрока.
func movement():
	var x_move = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_move = Input.get_action_strength("down")  - Input.get_action_strength("up")
	
	var move = Vector2(x_move, y_move) 
	
	if move != Vector2.ZERO:
		last_movement = move
		if find_child("FiniteStateMachine").get_current_state() != "Damage":
			find_child("FiniteStateMachine").change_state("Walk")
	else:
		if find_child("FiniteStateMachine").get_current_state() != "Damage":
			find_child("FiniteStateMachine").change_state("Idle")
		
	set_character_facing_direction(move)

	velocity = move.normalized() * movement_speed
	move_and_slide()

# Устанавливает направление персонажа в зависимости от вектора направления.
func set_character_facing_direction(direction: Vector2):
	var scale_x = sign(direction.x)
	if(scale_x != 0):
		transform_adjustment.scale.x = scale_x

# Обрабатывает полученный урон и уменьшает здоровье персонажа. Если здоровье достигает нуля, устанавливается состояние смерти.
func _on_hurt_box_hurt(damage, _angle, _knock_back):
	if !invulnerability: 
		if damage > 0:
			if find_child("FiniteStateMachine").get_current_state() != "Death" and find_child("FiniteStateMachine").get_current_state() != "Win":
				healing_label_show(clamp(damage - armor, 1.0, 999.0), true)
				find_child("FiniteStateMachine").change_state("Damage")

		health -= clamp(damage - armor, 1.0, 999.0)

func healing(value):
	healing_label_show(value, false)
	health += value

func healing_label_show(value, damage):
	healing_label.modulate.a = 255
	if damage:
		healing_label.modulate = Color(1, 0, 0)  # Красный цвет
		healing_label.text = "-" + str(value)
	else:
		healing_label.modulate = Color(65, 199, 0)  # Зеленый цвет
		healing_label.text = "+" + str(value)
	
	var tween = healing_label.create_tween()
	tween.tween_property(healing_label, "scale", Vector2(1.5, 1.5), 0.3)
	tween.play()
	
	tween.tween_property(healing_label, "modulate:a", 0, 0.2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()

# Возвращает местоположение случайного enemy для атаки.
func get_random_target():
	if enemy_close.size() > 0:
		return enemy_close.pick_random().global_position
	else:
		return Vector2.UP

#  Вызывается, когда враг входит в область обнаружения персонажа
func _on_enemy_detection_area_body_entered(body):
	if not enemy_close.has(body):
		enemy_close.append(body)

# Вызывается, когда враг покидает область обнаружения персонажа.
func _on_enemy_detection_area_body_exited(body):
	if enemy_close.has(body):
		enemy_close.erase(body)


# Обработчик таймера для атаки ice_spear
func _on_ice_spear_timer_timeout():
	ice_spear_ammo += ice_spear_base_ammo + additional_attack
	ice_spear_attack_timer.start()

# Обработчик таймера для выпуска ice_spear
func _on_ice_spear_attack_timer_timeout():
	if ice_spear_ammo > 0:
		var ice_spear_attack = attacks_preload["ice_spear"].instantiate()
		ice_spear_attack.position = position
		ice_spear_attack.target = get_random_target()
		ice_spear_attack.level = ice_spear_level
		add_child(ice_spear_attack)
		ice_spear_ammo -= 1
		if ice_spear_ammo >= 0:
			ice_spear_attack_timer.start()
		else:
			ice_spear_attack_timer.stop()

# Обработчик таймера для атаки tornado
func _on_tornado_timer_timeout():
	tornado_ammo += tornado_base_ammo + additional_attack
	tornado_attack_timer.start()

# Обработчик таймера для выпуска tornado
func _on_tornado_attack_timer_timeout():
	if tornado_ammo > 0:
		var tornado_attack = attacks_preload["tornado"].instantiate()
		tornado_attack.position = position
		tornado_attack.last_movement = last_movement
		tornado_attack.level = tornado_level
		add_child(tornado_attack)
		tornado_ammo -= 1
		if tornado_ammo >= 0:
			tornado_attack_timer.start()
		else:
			tornado_attack_timer.stop()

# Спавнит aura_wate
func spawn_aura_water():
	for child in aura_water_node.get_children():
		child.queue_free()
	var aura_water_spawn = attacks_preload["aura_water"].instantiate()
	aura_water_spawn.level = aura_water_level
	aura_water_node.add_child(aura_water_spawn)

func spawn_sticky_green_bulllet():
	for child in sticky_green_bulllet_node.get_children():
		child.queue_free()

	sticky_green_bullet_ammo = sticky_green_bullet_base_ammo
	sticky_green_bulllet_timer.start()

func _on_splash_timer_timeout():
	var new_splash_right = attacks_preload["splash"].instantiate()
	new_splash_right.level = splash_level
	new_splash_right.direction = 1
	add_child(new_splash_right)
	
	if double_splash == 1:
		var new_splash_left = attacks_preload["splash"].instantiate()
		new_splash_left.level = splash_level
		new_splash_left.direction = -1
		add_child(new_splash_left)

func _on_sticky_green_bullet_attack_timer_timeout():
	if sticky_green_bullet_ammo > 0:
		var new_sticky_green_bullet = attacks_preload["sticky_green_bullet"].instantiate()
		new_sticky_green_bullet.level = sticky_green_bullet_level
		sticky_green_bulllet_node.add_child(new_sticky_green_bullet)
		sticky_green_bulllet_timer.start()
		sticky_green_bullet_ammo -= 1
	
func _on_skipjack_timer_timeout():
	skipjack_ammo += skipjack_base_ammo + additional_attack
	skipjack_attack_timer.start()

func _on_skipjack_attack_timer_timeout():
	if skipjack_ammo > 0:
		var skipjack_attack = attacks_preload["skipjack"].instantiate()
		skipjack_attack.position = position
		skipjack_attack.target = get_random_target()
		skipjack_attack.level = skipjack_level
		add_child(skipjack_attack)
		skipjack_ammo -= 1
		if skipjack_ammo >= 0:
			skipjack_attack_timer.start()
		else:
			skipjack_attack_timer.stop()

func _on_boomerang_timer_timeout():
	boomerang_ammo += boomerang_base_ammo + additional_attack
	boomerang_attack_timer.start()

func _on_boomerang_attack_timer_timeout():
	if boomerang_ammo > 0:
		var boomerang_attack = attacks_preload["boomerang"].instantiate()
		boomerang_attack.position = position
		boomerang_attack.target = get_random_target()
		boomerang_attack.level = boomerang_level
		add_child(boomerang_attack)
		boomerang_ammo -= 1
		if boomerang_ammo >= 0:
			boomerang_attack_timer.start()
		else:
			boomerang_attack_timer.stop()

func _on_bang_sheep_timer_timeout():
	bang_sheep_ammo += bang_sheep_base_ammo + additional_attack
	bang_sheep_attack_timer.start()

func _on_bang_sheep_attack_timer_timeout():
	if bang_sheep_ammo > 0:
		var bang_sheep_attack = attacks_preload["bang_sheep"].instantiate()
		bang_sheep_attack.position = position
		bang_sheep_attack.target = get_random_target()
		bang_sheep_attack.level = bang_sheep_level
		add_child(bang_sheep_attack)
		bang_sheep_ammo -= 1
		if bang_sheep_ammo >= 0:
			bang_sheep_attack_timer.start()
		else:
			bang_sheep_attack_timer.stop()

func _on_trap_timer_timeout():
	var trap_attack = attacks_preload["trap"].instantiate()
	trap_attack.level = trap_level
	add_child(trap_attack)

func end_panel(state):
	if is_alive:
		is_alive = false
		death_panel.visible = true
		
		var tween = death_panel.create_tween()
		tween.tween_property(death_panel, "position", Vector2(210, 60), 0.3).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
		tween.play()
		if state == "Win":
			result_label.text = "You Win"
			victory_sound.play()
		else:
			result_label.text = "You Lose"
			lose_sound.play()

		get_tree().paused = true
		
		%EndStatLabel.text = "Gold collected: " + str(gold) + "\n" + "Enemy Killed: " + str(enemy_death_counter)

		var cur_gold = int(Global.character_data["GOLD"]["gold"]) + int(gold)
		Global.character_data["GOLD"]["gold"] = cur_gold
		Global.save_character_data()


# Обновляет интерфейс для отображения собранных улучшений и оружия.
func adjust_gui_collection(upgrade):
	var get_upgraded_displaynames = UpgradeDB.UPGRADES[upgrade]["displayname"]
	var get_type = UpgradeDB.UPGRADES[upgrade]["type"]
	
	if get_type != "item":
			var new_item = item_container.instantiate()
			new_item.upgrade = upgrade

			match get_type:
				"weapon":
					collected_weapons_grid.add_child(new_item)
				"upgrade":
					collected_upgrades_grid.add_child(new_item)

# Обновляет характеристики персонажа в зависимости от выбранного улучшения.
func upgrade_character(upgrade):
	match upgrade:
		# ====================================== icespear
		"icespear1":
			ice_spear_level = 1
			#ice_spear_base_ammo += 1
		"icespear2":
			ice_spear_level = 2
			#ice_spear_base_ammo += 1
		"icespear3":
			ice_spear_level = 3
			#ice_spear_base_ammo += 1
		"icespear4":
			ice_spear_level = 4
			#ice_spear_base_ammo += 1
		# ====================================== aura_water
		"aura_water1":
			aura_water_level = 1
			spawn_aura_water()
		"aura_water2":
			aura_water_level = 2
			spawn_aura_water()
		"aura_water3":
			aura_water_level = 3
			spawn_aura_water()
		"aura_water4":
			aura_water_level = 4
			spawn_aura_water()
		# ====================================== tornado
		"tornado1":
			tornado_level = 1
			#tornado_base_ammo += 1
		"tornado2":
			tornado_level = 2
			#tornado_base_ammo += 1
		"tornado3":
			tornado_level = 3
			#tornado_attack_spead -= 0.5
		"tornado4":
			tornado_level = 4
			#tornado_base_ammo += 1
		# ====================================== splash
		"splash1":
			splash_level = 1
		"splash2":
			splash_level = 2
		"splash3":
			splash_level = 3
		"splash4":
			splash_level = 4
		# ====================================== sticky_green_bullet4
		"sticky_green_bullet1":
			sticky_green_bullet_level = 1
			spawn_sticky_green_bulllet()
		"sticky_green_bullet2":
			sticky_green_bullet_level = 2
			spawn_sticky_green_bulllet()
		"sticky_green_bullet3":
			sticky_green_bullet_level = 3
			spawn_sticky_green_bulllet()
		"sticky_green_bullet4":
			sticky_green_bullet_level = 4
			spawn_sticky_green_bulllet()
		# ====================================== skipjack
		"skipjack1":
			skipjack_level = 1
		"skipjack2":
			skipjack_level = 2
		"skipjack3":
			skipjack_level = 3
		"skipjack4":
			skipjack_level = 4
		# ====================================== boomerang
		"boomerang1":
			boomerang_level = 1
		"boomerang2":
			boomerang_level = 2
		"boomerang3":
			boomerang_level = 3
		"boomerang4":
			boomerang_level = 4
		# ====================================== bang_sheep
		"bang_sheep1":
			bang_sheep_level = 1
		"bang_sheep2":
			bang_sheep_level = 2
		"bang_sheep3":
			bang_sheep_level = 3
		"bang_sheep4":
			bang_sheep_level = 4
		# ====================================== trap
		"trap1":
			trap_level = 1
		"trap2":
			trap_level = 2
		"trap3":
			trap_level = 3
		"trap4":
			trap_level = 4
		# ====================================== armor
		"armor1","armor2","armor3","armor4":
			armor += 1
		# ====================================== speed
		"speed1","speed2","speed3","speed4":
			movement_speed += movement_speed * 0.2
		# ====================================== tome
		"tome1","tome2","tome3","tome4":
			spell_size += 0.10
			if aura_water_level > 0:
				spawn_aura_water()
			if sticky_green_bullet_level > 0:
				spawn_sticky_green_bulllet()
		# ====================================== necklace
		"necklace1","necklace2","necklace3","necklace4":
			spell_cooldown += 0.05
		# ====================================== ring
		"ring1","ring2", "ring3","ring4":
			additional_attack += 1
		# ====================================== grab area
		"grab_area1", "grab_area2", "grab_area3", "grab_area4":
			grab_area_scale += grab_area.scale.x * 0.17
			grab_area.scale.x += grab_area_scale
			grab_area.scale.y += grab_area_scale
		# ====================================== experience_multiplier
		"experience_multiplier1", "experience_multiplier2", "experience_multiplier3", "experience_multiplier4":
			experience_multiplier += 0.1
		# ====================================== invulnerability
		"invulnerability1":
			invulnerability_level = 1
			invulnerability_time = 1
		"invulnerability2":
			invulnerability_level = 2
			invulnerability_time += 0.2
		"invulnerability3":
			invulnerability_level = 3
			invulnerability_time += 0.2
		"invulnerability4":
			invulnerability_level = 4
			invulnerability_time += 0.2
		# ====================================== vampirism
		"vampirism1":
			vampirism_probability += 0.1
			vampirism_recovery = 2
		"vampirism2":
			vampirism_probability += 0.05
			vampirism_recovery = 3
		"vampirism3":
			vampirism_probability += 0.05
			vampirism_recovery = 4
		"vampirism4":
			vampirism_probability += 0.1
			vampirism_recovery = 4
		# ====================================== mass_collection
		"mass_collection":
			grab_area.scale = Vector2(50,50)
			mass_collection_timer.start()
		# ====================================== food
		"food":
			healing(20)

	adjust_gui_collection(upgrade)
	find_child("FiniteStateMachine").change_state("Attack")

	upgrade_options.clear()
	collected_upgrades.append(upgrade)
	level_panel.visible = false
	level_panel.position = Vector2(800, 50)
	get_tree().paused = false
	calculate_experience(0)

	stats_label.text = "movement_speed: " + str(movement_speed) + "\nmax_health: " + str(max_health) + "\narmor: " + str(armor) + "\nspell_cooldown: " + str(spell_cooldown) + "\nspell_size: " + str(spell_size) + "\nadditional_attack: " + str(additional_attack)

# Выбирает случайный предмет для предложения игроку при повышении уровня.
func get_random_item():
	var dblist = []
	for i in UpgradeDB.UPGRADES:
		if i in collected_upgrades: # Find already collected upgrades
			pass
		elif i in upgrade_options: # If the upgrade is already an option
			pass
		elif UpgradeDB.UPGRADES[i]["prerequisite"].size() > 0: # Check for PreRequisite
			for n in UpgradeDB.UPGRADES[i]["prerequisite"]:
				if not n in collected_upgrades:
					pass
				else:
					dblist.append(i)
		else:
			dblist.append(i)
	if dblist.size() > 0:
		var random_item = dblist.pick_random()
		upgrade_options.append(random_item)
		return random_item
	else:
		return null

# =================================================================== EXPIRIENCE
# Обработчик входа в зону собираемых предметов.
func _on_grab_area_area_entered(area):
	if area.is_in_group("loot") or area.is_in_group("gold"):
		area.target = self

# Обработчик сбора 
func _on_collect_area_area_entered(area):
	if area.is_in_group("loot"):
		var gem_experience = area.collect()
		calculate_experience(gem_experience)
	
	if area.is_in_group("gold"):
		gold += area.collect()
		$GUILayer/GUI/GoldCollected/GoldCollectedLabel.text = str(gold)

# Вычисляет опыт и уровень персонажа на основе собранных опыта и устанавливает его панели опыта.
func calculate_experience(gem_experience):
	var exp_required = calculate_experience_cap()
	collected_experience += gem_experience * experience_multiplier
	if experience + collected_experience >= exp_required: # level up
		collected_experience -= exp_required - experience
		experience_level += 1
		experience = 0
		exp_required = calculate_experience_cap()
		if find_child("FiniteStateMachine").get_current_state() != "Death":
			find_child("FiniteStateMachine").change_state("LevelUp")
	else:
		experience += collected_experience
		collected_experience = 0
	
	set_expbar(experience, exp_required)

# Вычисляет верхний предел опыта для следующего уровня.
func calculate_experience_cap():
	var exp_cap = experience_level
	if experience_level < 10:
		exp_cap = experience_level * 5
	elif experience_level < 20:
		exp_cap = experience_level * 7
	elif experience_level < 25:
		exp_cap = experience_level * 9
	else: 
		exp_cap = experience_level * 12
	
	return exp_cap

# : Устанавливает значение панели опыта.
func set_expbar(set_value = 1, set_max_value = 100):
	experience_bar.value = set_value
	experience_bar.max_value = set_max_value
	
# =================================================================== GLOBAL TIMER
# Обработчик таймера для отслеживания времени игры и победы при достижении лимита времени.
func _on_timer_timeout():
	time += 1

	var min = str(time / 60) if time / 60 > 9 else "0" + str(time / 60)
	var sec = str(time % 60) if time % 60 > 9 else "0" + str(time % 60)
	game_time_label.text = min + ":" + sec
	
# =================================================================== GUI
# Обработчик кнопки "Меню".
func _on_exit_button_click_end():
	get_tree().paused = true
	var _level = get_tree().change_scene_to_file("res://src/title_screen/menu.tscn")

func _on_resume_button_click_end():
	var tween = pause_panel.create_tween()
	tween.tween_property(pause_panel, "position", Vector2(210, -270), 0.1).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
	pause_panel.visible = false
	get_tree().paused = false
	find_child("FiniteStateMachine").change_state("Idle")


func _on_button_menu_click_end():
	get_tree().paused = true
	var _level = get_tree().change_scene_to_file("res://src/title_screen/menu.tscn")

func _on_damage_received(enemy_damage):
	if !invulnerability:
		if enemy_damage > 0:
			if find_child("FiniteStateMachine").get_current_state() != "Death" and find_child("FiniteStateMachine").get_current_state() != "Win":
				find_child("FiniteStateMachine").change_state("Damage")

		health -= clamp(enemy_damage - armor, 1.0, 999.0)

func _on_mass_collection_timer_timeout():
	grab_area.scale = Vector2(1,1)

func _on_invulnerability_timer_timeout():
	invulnerability = true

	var new_invulnerability = attacks_preload["invulnerability"].instantiate()
	new_invulnerability.position = position
	new_invulnerability.level = invulnerability_level
	new_invulnerability.wait_time = invulnerability_time
	add_child(new_invulnerability)
		
	invulnerability_free_timer.set_wait_time(invulnerability_time)
	invulnerability_free_timer.start()

func _on_invulnerability_free_timer_timeout():
	invulnerability = false

func enemy_death(type = "base"):
	if randi() % 100 + 1 < vampirism_probability * 100:
		healing(vampirism_recovery)

	enemy_death_counter += 1
	$GUILayer/GUI/DeathEnemy/DeathEnemyLabel.text = str(enemy_death_counter)
	
func victory():
	find_child("FiniteStateMachine").change_state("Win")
