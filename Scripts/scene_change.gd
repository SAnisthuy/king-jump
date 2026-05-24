extends Node2D

@onready var countdown: Timer = $countdown

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	countdown.start()


	

func _on_countdown_timeout() -> void:
	get_tree().change_scene_to_file(GameManager.next_level)
	GameManager.player_health = 100
	GameManager.curr_level += 1
	Collectables.update_vals()
	Inventory.clear()
