extends Node2D
@onready var death_timer: Timer = $death_timer
var timed = false

func _ready() -> void:
	GameManager.next_level = "res://Scenes/level_4.tscn"
	GameManager.player_health = 100
	GameManager.curr_level = 3
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

func _on_nextlevel_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		if Collectables.coins == 0 and (Collectables.skulls == 0 or Collectables.skulls == null):
			get_tree().change_scene_to_file("res://Scenes/scene_change.tscn")
