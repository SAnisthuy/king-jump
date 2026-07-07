extends Node2D
func _ready() -> void:
	TimerGlobal.sector4 =TimerGlobal.time_elapsed - (TimerGlobal.sector1 + TimerGlobal.sector2 + TimerGlobal.sector3)
	TimerGlobal.timing = true
	GameManager.player_health = 100
	GameManager.curr_level = 5
	Collectables.update_vals()
	Inventory.clear()
