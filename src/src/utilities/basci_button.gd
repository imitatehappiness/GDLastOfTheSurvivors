extends Button

signal click_end()


func _on_mouse_entered():
	$SoundHover.play()


func _on_pressed():
	$SoundClick.play()


func _on_sound_click_finished():
	emit_signal("click_end")
