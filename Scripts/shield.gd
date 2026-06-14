extends Node2D

var pickup_available = false
var health = 5
@onready var equip_sfx: AudioStreamPlayer = $equipSFX
@onready var pickup_cooldown: Timer = $pickup_cooldown

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pickup_cooldown.start()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player") and pickup_available and Inventory.add_item({"name": "shield", "health": health}):
		equip_sfx.play()
		await equip_sfx.finished
		queue_free()
	pass

func _on_pickup_cooldown_timeout() -> void:
	pickup_available = true
