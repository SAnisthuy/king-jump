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
		
		
func spawn_skeleton():
	var skull = skeley.instantiate()
	get_parent().add_child(skull)
	skull.global_position = Vector2(global_position.x, global_position.y - 10)
	queue_free()

func _on_body_entered(body):
	if body.has_method("player"):
		spawn_skeleton()
