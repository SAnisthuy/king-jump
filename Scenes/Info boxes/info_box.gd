extends CanvasLayer

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED

func _on_button_pressed() -> void:
	get_tree().paused = false
	queue_free()
