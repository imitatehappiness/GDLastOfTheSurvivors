extends State

@onready var animation = $"../../TransformAdjustment/AnimationPlayer"
@onready var anim_sprite = $"../../TransformAdjustment/AnimatedSprite2D"
@onready var anim_respawn_sprite = $"../../TransformAdjustment/RespawnAnimatedSprite2D"

var can_transition : bool = false

func _ready():
	super._ready()

func enter():
	super.enter()
	owner.invulnerability = true
	owner.respawn = 0

	anim_sprite.visible = false
	anim_respawn_sprite.visible = true
	
	anim_respawn_sprite.play("Respawn")
	await anim_respawn_sprite.animation_finished
	
	anim_sprite.visible = true
	anim_respawn_sprite.visible = false
	
	var half_health = owner.max_health / 2
	owner.healing(half_health)
	
	owner.invulnerability = false
	can_transition = true

func transition():
	if can_transition:
		can_transition = false
		get_parent().change_state("Idle")
