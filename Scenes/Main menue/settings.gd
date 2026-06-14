extends CanvasLayer
@onready var main: HSlider = $Control/ColorRect/VBoxContainer/main
@onready var sfx: HSlider = $Control/ColorRect/VBoxContainer/sfx
@onready var music: HSlider = $Control/ColorRect/VBoxContainer/music

var main_val = 100

var bus_index_master = AudioServer.get_bus_index("Master")
var bus_index_sfx = AudioServer.get_bus_index("SFX")
var bus_index_music = AudioServer.get_bus_index("Music")

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	var master_val = AudioServer.get_bus_volume_linear(bus_index_master)
	main.value = master_val * 100

	var music_val = AudioServer.get_bus_volume_linear(bus_index_music)
	music.value = music_val * 100
	
	var sfx_val = AudioServer.get_bus_volume_linear(bus_index_sfx)
	sfx.value = sfx_val * 100

func _on_exit_pressed() -> void:
	GlobalAudios.play_button_click()
	get_tree().paused = false
	queue_free()

func _on_main_drag_ended(_value_changed: bool) -> void:
	if main.value == 0:
		sfx.modulate = Color(0.0, 0.0, 0.0, 0.808)
		music.modulate = Color(0.0, 0.0, 0.0, 0.808)
	else:
		sfx.modulate = Color(0.938, 0.938, 0.938, 1.0)
		music.modulate = Color(1.0, 1.0, 1.0, 1.0)
		
	var decibels = linear_to_db(main.value/100)
	AudioServer.set_bus_volume_db(bus_index_master, decibels)


func _on_sfx_drag_ended(_value_changed: bool) -> void:
	var decibels = linear_to_db(sfx.value/100)
	AudioServer.set_bus_volume_db(bus_index_sfx, decibels)


func _on_music_drag_ended(_value_changed: bool) -> void:
	var decibels = linear_to_db(music.value/100)
	AudioServer.set_bus_volume_db(bus_index_music, decibels)
