extends Area2D

var speed = 200
var dir: float
var velocity: Vector2
var hit = false
@onready var despawn: Timer = $despawn
@onready var contact_sfx: AudioStreamPlayer2D = $contactSFX

func _ready():
	velocity = Vector2.RIGHT.rotated(dir) * speed

func _physics_process(delta):
	if hit: return
	velocity.y += 1
	position += velocity * delta
	rotation = velocity.angle()


func _on_body_entered(body: Node2D) -> void:
	if hit:
		return
	for thing in get_overlapping_bodies():
		if thing.has_method("enemy"):
			thing.take_damage(40)

	if body.has_method("player"):
		return
	if body.has_method("enemy"):
		queue_free()
	else:
		velocity = Vector2.ZERO
		hit = true
		contact_sfx.play()
		await contact_sfx.finished
		despawn.start()

func _on_despawn_timeout() -> void:
	queue_free()
