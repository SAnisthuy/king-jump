extends Node2D
@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	GameManager.player_health = 0
	timer.start()

func _on_timer_timeout() -> void:
	GameManager.player_health = 100
	Collectables.update_vals()
	get_tree().reload_current_scene()
