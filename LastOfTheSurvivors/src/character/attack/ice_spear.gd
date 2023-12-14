
extends Area2D


var level = 1 # Уровень ледяного копья
var health = 1 # Количество целей, которых ледяное копье может поразить
var speed = 300 # Скорость движения ледяного копья
var damage = 5 # Количество урона, наносимого целям
var attack_size = 1.0 # Размер атаки ледяного копья

# Переменные для управления направлением и целью ледяного копья
var target = Vector2.ZERO # Цель ледяного копья
var angle = Vector2.ZERO # Угол в направлении цели

@onready var character = get_tree().get_first_node_in_group("character")

signal remove_from_array(object)

func _ready():
	# Настройка начального угла в направлении цели
	angle = global_position.direction_to(target)
	rotation = angle.angle() + deg_to_rad(135)
	match level:
		1:
			health = 4 
			speed = 150
			damage = 5
			attack_size = 1.0 * (1 + character.spell_size)
		2:
			health = 5 
			speed = 150
			damage = 6
			attack_size = 1.0 * (1 + character.spell_size)
		3:
			health = 7
			speed = 200
			damage = 8
			attack_size = 1.0 * (1 + character.spell_size)
		4:
			health = 9
			speed = 250
			damage = 10
			attack_size = 1.0 * (1 + character.spell_size)
	
	
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1)*attack_size, 1).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
	$AnimationPlayer.play("Idle")


func _physics_process(delta):
	position += angle * speed * delta


func enemy_hit(charge = 1):
	health -= charge
	if health <= 0:
		emit_signal("remove_from_array", self)
		queue_free()


func _on_timer_timeout():
	emit_signal("remove_from_array", self)
	queue_free()
