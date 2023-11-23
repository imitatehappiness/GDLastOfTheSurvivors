extends TextureButton

signal click_end()

@export var label_text = ""
@export var font_size = 300

func _ready():
	$Label.add_theme_font_size_override("font:size", font_size)
	set_label_text()

func set_label_text(text = label_text):
	$Label.text = text

func _on_button_down():
	position.y += 1

func _on_button_up():
	position.y -= 1

func _on_sound_click_finished():
	emit_signal("click_end")

func _on_pressed():
	position.y -= 1
	$SoundClick.play()
