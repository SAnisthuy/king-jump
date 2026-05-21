extends Label

var needed = 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = "Coins needed: " + str(needed)

func _on_coin_coin_collected() -> void:
	needed -= 1


func _on_nextlevel_body_entered(body: Node2D) -> void:
	if needed == 0:
		get_tree().change_scene_to_file("res://Scenes/scene_change.tscn")
