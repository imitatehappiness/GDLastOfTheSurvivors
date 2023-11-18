extends Line2D

@export var lenght = 50

var point = Vector2.ZERO

func _physics_process(_delta):
	global_position = Vector2.ZERO
	global_rotation = 0
	
	point = get_parent().global_position
	
	add_point(point)
	
	while get_point_count() > lenght:
		remove_point(0)
