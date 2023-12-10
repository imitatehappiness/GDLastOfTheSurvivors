extends State

@onready var collision = $"../../CharacterDetection/CollisionShape2D"

var character_entered : bool = false:
	set(value):
		character_entered = value
		collision.set_deferred("disable", value)
		
func transition():
	if character_entered:
		get_parent().change_state("Follow")

func _on_character_detection_body_entered(body):
	character_entered = true
