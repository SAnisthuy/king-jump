extends Area2D

var speed = 200
var dir: float

func _physics_process(delta):
	position += Vector2.RIGHT.rotated(dir) * speed * delta


func _on_body_entered(body: Node2D) -> void:
	for thing in get_overlapping_bodies():
		if thing.has_method("enemy"):
			thing.take_damage(30)
	if body.has_method("player"):
		return
	queue_free()
