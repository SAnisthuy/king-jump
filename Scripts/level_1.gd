extends Node2D
@onready var main: TileMap = $mapping/Main

func _ready() -> void:
	TimerGlobal.timing = true
	GameManager.player_health = 100
	GameManager.curr_level = 1
	Collectables.update_vals()
	Inventory.clear()
