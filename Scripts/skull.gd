extends Node2D

var pickup_available = false
@onready var pickup_cooldown: Timer = $pickup_cooldown
@onready var collect_sfx: AudioStreamPlayer = $collectSFX

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pickup_cooldown.start()

var dir = 1
var lim_up = position.y + 5
var lim_down = position.y - 5


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player") and pickup_available:
		if Collectables.skulls > 0:
			Collectables.skulls -= 1
		GlobalAudios.collect_play()
		queue_free()
	pass


func _on_pickup_cooldown_timeout() -> void:
	pickup_available = true
	
