extends Sprite2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		Inventory.remove_item("key")
		queue_free()
