extends Area2D

var scene = preload("res://Scenes/Info boxes/skeley_hard.tscn")

func _ready() -> void:
	if GameManager.tut["skeleton_hard"]:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		GameManager.tut["skeleton_hard"] = true
		var scene_inst = scene.instantiate()
		get_tree().root.add_child(scene_inst)
		get_tree().paused = true
		queue_free()
