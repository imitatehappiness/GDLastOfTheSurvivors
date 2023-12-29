extends State

func _ready():
	super._ready()

func enter():
	super.enter()
	show_pause_panel()

func show_pause_panel():
	owner.pause_panel.visible = true
	get_tree().paused = true
	var tween = owner.pause_panel.create_tween()
	tween.tween_property(owner.pause_panel, "position", Vector2(210, 60), 0.1).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
