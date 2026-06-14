extends Area2D

var speed = 200
var body: Node2D
var direction = null

var skeley = preload("res://Scenes/skeleton.tscn")

func _ready():
	if body:
		direction = (body.get_node("target point").global_position - global_position).normalized()
	else:
		queue_free()
	
	
func _physics_process(delta):
	if body:
		direction = (body.get_node("target point").global_position - global_position).normalized()

	position += direction * speed * delta
		
		
func _on_body_entered(body_detected):
	if body_detected.has_method("player"):
		var pos = global_position
		call_deferred("_spawn_skeleton_deferred", pos)
		queue_free()

func _spawn_skeleton_deferred(pos):
	var skull = skeley.instantiate()
	get_parent().add_child(skull)
	skull.global_position = pos + Vector2(0, -10)
