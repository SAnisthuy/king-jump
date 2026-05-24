extends Area2D

var questions = preload("res://Scenes/quiz.tscn")

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		var quiz_instance = questions.instantiate()
		get_parent().add_child(quiz_instance)
		get_tree().paused = true
		queue_free()
		Collectables.coins -= 1
