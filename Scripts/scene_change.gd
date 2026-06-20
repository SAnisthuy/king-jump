extends Node2D

@onready var countdown: Timer = $countdown

func _ready() -> void:
	countdown.start()

func _on_countdown_timeout() -> void:
	get_tree().change_scene_to_file(GameManager.next_level)
