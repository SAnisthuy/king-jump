extends Node2D
var pickup_available = false
var health = 5
@onready var pickup_cooldown: Timer = $pickup_cooldown

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pickup_cooldown.start()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player") and pickup_available:
		if Inventory.add_item({"name": "spear", "health": health}):
			queue_free()
	pass
func _on_pickup_cooldown_timeout() -> void:
	pickup_available = true
	
