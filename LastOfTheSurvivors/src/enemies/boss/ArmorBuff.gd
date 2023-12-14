extends State

var can_transition : bool = false

func enter():
	super.enter()
	animation_player.play("Armor_buff")
	await animation_player.animation_finished
	can_transition = true

func transition():
	if can_transition:
		can_transition = false
		get_parent().change_state("Follow")

func update_scale():
	var tween = owner.create_tween()
	tween.tween_property(owner, "scale", Vector2(2, 2), 1).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
