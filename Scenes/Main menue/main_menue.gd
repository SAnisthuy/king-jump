extends Control

@onready var point_light_2d: PointLight2D = $PointLight2D
var level = preload("res://Scenes/level_1.tscn")

func _process(delta: float) -> void:
	point_light_2d.global_position = get_global_mouse_position()

func _on_button_1_pressed() -> void: # PLAY BUTTON
	get_tree().change_scene_to_packed(level)

func _on_button_2_pressed() -> void: #QUIT BUTTON
	get_tree().quit()
