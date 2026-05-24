extends ProgressBar

func _on_skeleton_skeley_damaged(damage: int) -> void:
	value -= damage
