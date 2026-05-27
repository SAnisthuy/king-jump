extends Area2D

var speed = 200
var dir: float
var velocity: Vector2

func _ready():
	velocity = Vector2.RIGHT.rotated(dir) * speed

func _physics_process(delta):
	velocity.y += 1
	
	position += velocity * delta
	
	rotation = velocity.angle()


func _on_body_entered(body: Node2D) -> void:
	for thing in get_overlapping_bodies():
		if thing.has_method("enemy"):
			thing.take_damage(30)

	if body.has_method("player"):
		return
		
	queue_free()
