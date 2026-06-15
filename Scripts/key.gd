extends Area2D
@onready var cooldown: Timer = $cooldown

var in_range = false
var piackable = false
func _ready() -> void:
	cooldown.start()

func _process(_delta: float) -> void:
	if in_range and piackable:
		if Inventory.add_item({"name": "key", "health": 5}):
			GlobalAudios.collect_key_play()
			queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		in_range = true		


func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		in_range = false


func _on_cooldown_timeout() -> void:
	piackable = true
