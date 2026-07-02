extends Area2D
var next_level = preload("res://Scenes/necromancers_lair.tscn")
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		if {"name": "key", "health": 5} in Inventory.inventory:
			#get_tree().change_scene_to_packed(next_level)
			get_tree().call_deferred("change_scene_to_packed", next_level)
			
