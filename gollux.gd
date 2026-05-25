extends CharacterBody2D

@onready var golly: AnimatedSprite2D = $golly
@onready var hitbox: Area2D = $hitbox

var chase = false
var attack = false
var heal = false
var damage = false
var dying = false

var health = 100

var target = null

@onready var wallcheck: RayCast2D = $raycasts/wallcheck
@onready var floorcheck: RayCast2D = $raycasts/floorcheck
@onready var raycasts: Node2D = $raycasts
@onready var cooldown_timer: Timer = $cooldown_timer

var direction = -1

signal golly_damaged(amount: int)

var patrolSpeed = 60
var chaseSpeed = 160

var cooldown = true


func _physics_process(delta: float) -> void: 
	if direction < 0:
		golly.flip_h = true
		raycasts.scale.x = -1
	else:
		golly.flip_h = false
		raycasts.scale.x = 1
	if not is_on_floor():
		velocity += get_gravity() * delta
	if attack:
		attacking()
	elif chase:
		chasing()
	else:
		patrolling()
	move_and_slide()
	

func chasing():
	var dist = target.position.x - position.x
	direction = sign(dist)

	if is_colliding():
		velocity.x = 0

		if golly.animation != "idle":
			golly.play("idle")

		return

	velocity.x = direction * chaseSpeed

	if golly.animation != "chase":
		golly.play("chase")

func patrolling():
	if is_colliding():
		direction *= -1
	velocity.x = direction * patrolSpeed
	if golly.animation != "move":
		golly.play("move")
		
	
func attacking():

	if cooldown:
		cooldown = false
		cooldown_timer.start()

		velocity.x = 0

		var attacks = ["attack1", "attack2"]
		var chosen = attacks.pick_random()

		golly.play(chosen)
	


func take_damage(amount):
	if dying:
		return

	health -= 25
	golly_damaged.emit(25)

	if health <= 0:
		queue_free()


func is_colliding():
	return wallcheck.is_colliding() or !floorcheck.is_colliding()
	
func _on_detection_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		chase = true
		target = body

func _on_detection_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		chase = false
		target = null

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		attack = true

func _on_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		attack = false
	
func enemy(): pass

func _on_golly_frame_changed() -> void:
	if golly.animation.begins_with("attack"):
		if golly.frame == 6 and attack and target != null:
			target.take_damage(15)


func _on_cooldown_timer_timeout() -> void:
	cooldown = true


func _on_golly_animation_finished() -> void:
	if chase:
		chasing()
	else:
		patrolling()
