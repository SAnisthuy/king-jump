extends Node2D

func _ready() -> void:
	TimerGlobal.sector2 = TimerGlobal.time_elapsed - TimerGlobal.sector1
	
	TimerGlobal.timing = true
	GameManager.player_health = 100
	GameManager.curr_level = 3
	Collectables.update_vals()
	Inventory.clear()
