extends State

@onready var animation = $"../../TransformAdjustment/AnimationPlayer"

var can_transition : bool = false

func _ready():
	super._ready()

func enter():
	super.enter()
	animation.play("Death")
	await animation.animation_finished
	owner.end_panel("Death")
