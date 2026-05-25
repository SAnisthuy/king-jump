extends ProgressBar

func _on_gollux_golly_damaged(amount: int) -> void:
	value -= amount
