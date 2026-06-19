extends CanvasLayer

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED

func _on_button_pressed() -> void:
	GlobalAudios.play_button_click()
	get_tree().paused = false
	get_tree().reload_current_scene()
	queue_free()
