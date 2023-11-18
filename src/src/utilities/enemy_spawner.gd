extends Node2D

# Экспортируемая переменная, содержащая информацию о спавне врагов
@export var spawns: Array[Spawn_information] = []

@onready var character = get_tree().get_first_node_in_group("character")

var time = 0
var max_distance = 1450  # Максимальное расстояние от центра карты

func _on_timer_timeout():
	spawn()

# Метод для получения случайной позиции в пределах видимой области экрана, близкой к центру карты
func get_random_position():
	# Определяем видимую область экрана
	var vpr = get_viewport_rect().size * 1.1

	# Определяем границы видимой области
	var top_left = Vector2(character.global_position.x - vpr.x / 2, character.global_position.y - vpr.y / 2)
	var top_right = Vector2(character.global_position.x + vpr.x / 2, character.global_position.y - vpr.y / 2)
	var bottom_left = Vector2(character.global_position.x - vpr.x / 2, character.global_position.y + vpr.y / 2)
	var bottom_right = Vector2(character.global_position.x + vpr.x / 2, character.global_position.y + vpr.y / 2)

	# Выбираем случайную сторону для появления персонажа
	var pos_side = ["up", "down", "right", "left"].pick_random()
	var spawn_pos1 = Vector2.ZERO
	var spawn_pos2 = Vector2.ZERO

	match pos_side:
		"up":
			spawn_pos1 = top_left
			spawn_pos2 = top_right
		"down":
			spawn_pos1 = bottom_left
			spawn_pos2 = bottom_right
		"right":
			spawn_pos1 = top_right
			spawn_pos2 = bottom_right
		"left":
			spawn_pos1 = top_left
			spawn_pos2 = bottom_left

	var x_spawn = randf_range(spawn_pos1.x, spawn_pos2.x)
	var y_spawn = randf_range(spawn_pos1.y, spawn_pos2.y)
	
	if x_spawn > max_distance or x_spawn < -max_distance:
		x_spawn = 0
	if y_spawn > max_distance or y_spawn < -max_distance:
		y_spawn = 0
	
	get_tree().create_timer(0.001).timeout
	return Vector2(x_spawn, y_spawn)

func spawn():
	time += 1
	var enemy_spawns = spawns
	for i in enemy_spawns:
		if time >= i.time_start and time <= i.time_end:
			if i.spawn_delay_counter < i.enemy_spawn_delay:
				i.spawn_delay_counter += 1
			else:
				i.spawn_delay_counter = 0
				var new_enemy = i.enemy
				var counter = 0
				while counter < i.enemy_num:
					var enemy_spawn = new_enemy.instantiate()
					enemy_spawn.global_position = get_random_position()
					add_child(enemy_spawn)
					counter += 1
