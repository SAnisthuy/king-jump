extends Control

@onready var bg: Sprite2D = $bg
@onready var pin: Node2D = $Node2D

var door_pos = GameManager.doors[1]


func _process(_delta: float):
	door_pos = GameManager.doors[GameManager.curr_level]
	var player_pos = GameManager.player_pos
	var dir = door_pos - player_pos
	pin.rotation = dir.angle()


func _on_area_2d_mouse_entered() -> void:
	modulate = Color(Color(1.0, 1.0, 1.0, 1.0))


func _on_area_2d_mouse_exited() -> void:
	modulate = Color(Color(0.671, 0.651, 0.475, 0.722))
