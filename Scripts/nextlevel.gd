extends Area2D

var door_boss: Sprite2D

func _process(_delta: float) -> void:
	if GameManager.curr_level == 4:
		door_boss = $"../doorBoss"

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		if {"name": "key", "health": 5} in Inventory.inventory:
			body.global_position = door_boss.global_position
