extends Node2D

@export var spawn_info: Spawn_diagonal_information
@onready var character = get_tree().get_first_node_in_group("character")
@onready var free_timer = get_node("%FreeTimer")

var time = 0
var max_distance = 1500  # Максимальное расстояние от центра карты

func spawn():
	var top_spawn = true
	if randi() % 2 == 0:
		top_spawn = false
	
	time += 1
	if time == spawn_info.time_spawn:
		if spawn_info.time_free > 0:
			free_timer.set_wait_time(spawn_info.time_free)
			free_timer.start()
		var new_enemy = spawn_info.enemy
		var counter = 0
		while counter < spawn_info.enemy_num:

			var x = character.global_position.x - character.get_viewport_rect().size.x / 2
			
			var y = character.global_position.y
			
			if top_spawn:
				y += character.get_viewport_rect().size.y
			else:
				y -= character.get_viewport_rect().size.y
			
			x += 110 * counter

			if not (x > max_distance or x < -max_distance or y > max_distance or y< -max_distance):
				var enemy_spawn = new_enemy.instantiate()
				enemy_spawn.global_position = Vector2(x, y)
				add_child(enemy_spawn)
			counter += 1


func _on_free_timer_timeout():
	queue_free()

func _on_timer_timeout():
	spawn()
