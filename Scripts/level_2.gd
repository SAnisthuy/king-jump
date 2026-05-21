extends Node2D


func _ready() -> void:
	GameManager.next_level = "res://Scenes/level_3.tscn"

func _on_player_death() -> void:
	GameManager.player_health = 100
	get_tree().reload_current_scene()
