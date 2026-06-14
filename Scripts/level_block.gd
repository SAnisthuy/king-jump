extends StaticBody2D
@onready var text: Label = $text

func _ready() -> void:
	text.visible = false



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		if Collectables.coins == 0 and (Collectables.skulls == 0 or Collectables.skulls == null):
			queue_free()
		else:
			text.visible = true


func _on_area_2d_body_exited(_body: Node2D) -> void:
	text.visible = false
