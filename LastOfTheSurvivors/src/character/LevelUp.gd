extends State

func _ready():
	super._ready()

func enter():
	super.enter()
	level_up()

func level_up():
	owner.level_up_sound.play()
	owner.level_label.text = str("LV: ", owner.experience_level)
	var tween = owner.level_panel.create_tween()
	tween.tween_property(owner.level_panel, "position", Vector2(210, 60), 0.2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
	owner.level_panel.visible = true
	var options = 0
	var options_max = 3
	
	for child in owner.upgrade_options_vbox.get_children():
		child.queue_free()
	
	while options < options_max:
		var option_choice = owner.item_options.instantiate()
		option_choice.item = owner.get_random_item()
		owner.upgrade_options_vbox.add_child(option_choice)
		options += 1

	get_tree().paused = true
