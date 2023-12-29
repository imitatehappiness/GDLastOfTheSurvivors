extends State

@onready var animation = $"../../TransformAdjustment/AnimationPlayer"

var can_transition : bool = false

func _ready():
	super._ready()

func enter():
	super.enter()
	owner.end_panel("Win")
