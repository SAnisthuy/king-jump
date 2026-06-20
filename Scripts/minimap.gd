extends CanvasLayer
@onready var camera_2d: Camera2D = $SubViewportContainer/SubViewport/Camera2D

func _process(delta: float) -> void:
	camera_2d.position = GameManager.player_pos
