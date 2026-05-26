extends Node2D
var timed = false
@onready var death_timer: Timer = $death_timer

func _ready() -> void:
	GameManager.player_health = 100
	GameManager.curr_level = 4
	Collectables.update_vals()
	Inventory.clear()

func _on_player_death() -> void:
	GameManager.player_health = 0
	if !timed:
		timed = true
		death_timer.start()
	
func _on_death_timer_timeout() -> void:
	GameManager.player_health = 100
	Collectables.update_vals()
	Inventory.clear()
	get_tree().reload_current_scene()
