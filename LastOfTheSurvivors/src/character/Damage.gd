extends State

@onready var animation = $"../../TransformAdjustment/AnimationPlayer"
@onready var get_damage_sound = $"../../GetDamagePlay"

var can_transition : bool = false

func _ready():
	super._ready()

func enter():
	super.enter()
	get_damage_sound.play()
	animation.play("Damage")
	await animation.animation_finished
	can_transition = true
	set_idle_state()

func set_idle_state():
	if can_transition:
		can_transition = false
		get_parent().change_state("Idle")
