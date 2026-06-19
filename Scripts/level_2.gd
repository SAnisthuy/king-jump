extends Node2D

func _ready() -> void:
	GameManager.next_level = "res://Scenes/level_3.tscn"
	GameManager.player_health = 100
	GameManager.curr_level = 2
	Collectables.update_vals()
	Inventory.clear()
