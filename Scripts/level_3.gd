extends Node2D
@onready var death_timer: Timer = $death_timer

func _ready() -> void:
	GameManager.next_level = "res://Scenes/level_3.tscn"

func _on_player_death() -> void:
	GameManager.player_health = 100
	death_timer.start()




func _on_death_timer_timeout() -> void:
	get_tree().reload_current_scene()
