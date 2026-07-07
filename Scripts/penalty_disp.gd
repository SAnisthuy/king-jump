extends Label

var custom_size = 1

func _process(_delta: float) -> void:
	add_theme_font_size_override("font_size", custom_size)

func penalty():
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property(self, "custom_size", 23, 0.4)
	tween.tween_property(self, "modulate", Color(0.794, 0.0, 0.0, 1.0), 0.4)
	tween.chain().tween_property(self, "modulate", Color(0.794, 0.0, 0.0, 0.0), 0.4)
