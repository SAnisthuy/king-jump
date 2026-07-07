extends Node2D
var timed = false

func _ready() -> void:
	TimerGlobal.sector3 = TimerGlobal.time_elapsed - (TimerGlobal.sector1 + TimerGlobal.sector2)
	
	TimerGlobal.timing = true
	GameManager.player_health = 100
	GameManager.curr_level = 4
	Collectables.update_vals()
	Inventory.clear()
