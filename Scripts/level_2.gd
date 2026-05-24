extends Node2D
@onready var death_countdown: Timer = $"Death countdown"
var timing = false

func _ready() -> void:
	GameManager.next_level = "res://Scenes/level_3.tscn"

func _on_player_death() -> void:
	if timing: 
		return
	death_countdown.start()
	timing = true
	GameManager.player_health = 0
	Inventory.clear()

func _on_death_countdown_timeout() -> void:
	get_tree().reload_current_scene()
	GameManager.player_health = 100
	Collectables.update_vals()


func _on_nextlevel_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		if Collectables.coins == 0:
			get_tree().change_scene_to_file("res://Scenes/scene_change.tscn")
