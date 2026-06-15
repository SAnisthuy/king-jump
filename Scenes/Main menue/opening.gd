extends CanvasLayer

var main_menue = preload("res://Scenes/Main menue/main_menue.tscn")
@onready var scene_4: TextureRect = $"Scene 4"
@onready var scene_3: TextureRect = $"Scene 3"
@onready var scene_2: TextureRect = $"Scene 2"
@onready var scene_1: TextureRect = $"Scene 1"


@onready var cooldown: Timer = $cooldown

@onready var open_list = [scene_1, scene_2, scene_3, scene_4]
var i = 0


func _on_cooldown_timeout() -> void:
	open_list[i].visible = false
	i += 1
	if i >= 4:
		cooldown.stop()
		get_tree().change_scene_to_packed(main_menue)
		
