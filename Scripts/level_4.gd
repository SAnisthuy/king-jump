extends Node2D
var timed = false

func _ready() -> void:
	GameManager.player_health = 100
	GameManager.curr_level = 4
	Collectables.update_vals()
	Inventory.clear()
