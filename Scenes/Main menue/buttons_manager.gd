extends Node2D




func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()


func _on_settings_pressed() -> void:
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Main menue/main_menue.tscn")
