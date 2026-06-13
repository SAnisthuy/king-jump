extends Area2D
@onready var timer: Timer = $Timer

const restart_scene = preload("res://Scenes/restart_menue.tscn")

var triggered = false

func _on_body_entered(_body: Node2D) -> void:
	if triggered:
		return
	triggered = true
	GameManager.player_health = 0
