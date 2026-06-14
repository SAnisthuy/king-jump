extends Area2D
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		if {"name": "key", "health": 5} in Inventory.inventory:
			body.global_position = $"../doorBoss".global_position
