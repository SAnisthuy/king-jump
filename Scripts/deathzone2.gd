extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		body.take_damage(1000, Vector2(0, 0))
