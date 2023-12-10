extends State

var can_transition: bool = false
var duration = 0.8

func dash():
	var tween = create_tween()
	tween.tween_property(owner, "position", character.position, duration)
	await  tween.finished
	
func enter():
	super.enter()
	animation_player.play("Glowing")
	await dash()
	can_transition = true
	
func transition():
	if can_transition:
		can_transition = false
		get_parent().change_state("Follow")
