extends Area2D
@onready var door_boss: Sprite2D = $"../doorBoss"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		if {"name": "key", "health": 5} in Inventory.inventory:
			body.global_position = door_boss.global_position
