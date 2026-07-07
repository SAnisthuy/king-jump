extends Node2D

@onready var countdown: Timer = $countdown

func _ready() -> void:
	TimerGlobal.timing = false
	countdown.start()

func _on_countdown_timeout() -> void:
	TimerGlobal.timing = true
	get_tree().change_scene_to_file(GameManager.levels[GameManager.curr_level + 1])
