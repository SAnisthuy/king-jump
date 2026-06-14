extends Node2D

var settings_menue = preload("res://Scenes/Main menue/settings.tscn")



func _on_restart_pressed() -> void:
	GlobalAudios.play_button_click()
	get_tree().reload_current_scene()


func _on_settings_pressed() -> void:
	GlobalAudios.play_button_click()
	var settings_inst = settings_menue.instantiate()
	get_tree().root.add_child(settings_inst)
	get_tree().paused = true


func _on_quit_pressed() -> void:
	GlobalAudios.play_button_click()
	get_tree().change_scene_to_file("res://Scenes/Main menue/main_menue.tscn")
