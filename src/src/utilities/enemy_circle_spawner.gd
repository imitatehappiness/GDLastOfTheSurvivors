extends Node2D

@export var spawn_info: Spawn_circle_information
@onready var character = get_tree().get_first_node_in_group("character")
@onready var free_timer = get_node("%FreeTimer")

var time = 0
var max_distance = 1500  # Максимальное расстояние от центра карты

func spawn():
	time += 1
	if time == spawn_info.time_spawn:
		if spawn_info.time_free > 0:
			free_timer.set_wait_time(spawn_info.time_free)
			free_timer.start()
		var new_enemy = spawn_info.enemy
		var counter = 0
		while counter < spawn_info.enemy_num:
			var angle = counter * (2 * PI / spawn_info.enemy_num)
			var x = character.global_position.x + spawn_info.radius * cos(angle)
			var y = character.global_position.y + spawn_info.radius * sin(angle)
			if not (x > max_distance or x < -max_distance or y > max_distance or y< -max_distance):
				var enemy_spawn = new_enemy.instantiate()
				enemy_spawn.global_position = Vector2(x, y)
				add_child(enemy_spawn)
			counter += 1

func _on_free_timer_timeout():
	queue_free()

func _on_timer_timeout():
	spawn()
