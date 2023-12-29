extends State

@onready var animation = $"../../TransformAdjustment/AnimationPlayer"

func _ready():
	super._ready()

func enter():
	super.enter()
	animation.play("Walk")


