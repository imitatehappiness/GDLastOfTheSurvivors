extends Area2D

@export_enum("Cooldown", "HitOnce", "DisableHitBox") var hurt_box_type = 0

@onready var collision = $CollisionShape2D
@onready var disable_timer = $DisableTimer

signal hurt(damage, angle, knockback)

var hit_once_array = []

func _on_area_entered(area):

	if area.is_in_group("attack"):
		if not area.get("damage") == null:
			match hurt_box_type:
				0: #Cooldown
					collision.call_deferred("set", "disabled", true)
					disable_timer.start()
				1: #HitOnce
#					if !hit_once_array.has(area):
#						hit_once_array.append(area)
#						if area.has_signal("remove_from_array"):
#							if not area.is_connected("remove_from_array", Callable(self, "remove_from_list")):
#								area.connect("remove_from_array", Callable(self, "remove_from_list"))
#					else:
#						return
					pass
				2: #DisableHitBox
					if area.has_method("tempdisabled"):
						area.tempdisabled()

			var damage = area.damage
			var angle = Vector2.ZERO
			var knock_back = 1
			if not area.get("angle") == null:
				angle = area.angle
			if not area.get("knockback_amount") == null:
				knock_back = area.knockback_amount

			emit_signal("hurt", damage, angle, knock_back)
			if area.has_method("enemy_hit"):
				area.enemy_hit(1)

func _on_disable_timer_timeout():
	collision.call_deferred("set", "disabled", false)

func remove_from_list(object):
	if hit_once_array.has(object):
		hit_once_array.erase(object)
