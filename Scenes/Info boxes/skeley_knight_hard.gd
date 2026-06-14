extends Area2D

var scene = preload("res://Scenes/Info boxes/skeley_hard.tscn")

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		var scene_inst = scene.instantiate()
		get_tree().root.add_child(scene_inst)
		get_tree().paused = true
		queue_free()
