extends Area2D
@onready var timer: Timer = $Timer

var collectable = false

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player") and collectable:
		GameManager.player.heal(20)
		queue_free()

func _on_timer_timeout() -> void:
	collectable = true
