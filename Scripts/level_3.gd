extends Node2D
var timed = false

var scene_change = preload("res://Scenes/scene_change.tscn")

func _ready() -> void:
	GameManager.next_level = "res://Scenes/level_4.tscn"
	GameManager.player_health = 100
	GameManager.curr_level = 3
	Collectables.update_vals()
	Inventory.clear()

func _on_nextlevel_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		if Collectables.coins == 0 and (Collectables.skulls == 0 or Collectables.skulls == null):
			change()
			
func change():
	get_tree().call_deferred("change_scene_to_packed", scene_change)
