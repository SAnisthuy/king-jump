extends Label

var needed = 4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = "Coins needed: " + str(needed)


func _on_coin_coin_collected() -> void:
	needed -= 1


func _on_nextlevel_body_entered(body: Node2D) -> void:
	if needed == 0:
		print(true)
		get_tree().change_scene_to_file("res://Scenes/level_2.tscn")
