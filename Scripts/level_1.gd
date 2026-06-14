extends Node2D

var scene_change = preload("res://Scenes/scene_change.tscn")

func _on_nextlevel_body_entered(_body: Node2D) -> void:
	if Collectables.coins == 0:
		change()
func change():
	get_tree().call_deferred("change_scene_to_packed", scene_change)
