extends Control

@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var button_sfx: AudioStreamPlayer = $buttonSFX
var tut = preload("res://Scenes/Main menue/tutorial.tscn")


func _process(_delta: float) -> void:

	point_light_2d.global_position = get_global_mouse_position()

func _on_button_1_pressed() -> void: # PLAY BUTTON
	button_sfx.play()
	await button_sfx.finished
	if GameManager.opening_tut:
		get_tree().change_scene_to_packed(GameManager.levels[GameManager.curr_level])
	else:	
		get_tree().change_scene_to_packed(tut)

func _on_button_2_pressed() -> void: #QUIT BUTTON
	button_sfx.play()
	await button_sfx.finished
	get_tree().quit()
