extends CharacterBody2D

@onready var golly: AnimatedSprite2D = $golly
@onready var hitbox: Area2D = $hitbox

var key_scene = preload("res://Scenes/key.tscn")

var chase = false
var attack = false
var heal = false
var damage = 100
var dying = false

var curr_attacking = false

var health = 100

var target = null

@onready var wallcheck: RayCast2D = $raycasts/wallcheck
@onready var floorcheck: RayCast2D = $raycasts/floorcheck
@onready var raycasts: Node2D = $raycasts
@onready var cooldown_timer: Timer = $cooldown_timer
@onready var damage_cooldown: Timer = $damage_cooldown

@onready var attack_sfx: AudioStreamPlayer = $attackSFX
@onready var walk_sfx: AudioStreamPlayer2D = $walkSFX
@onready var hurt_sfx: AudioStreamPlayer = $hurtSFX

var direction = -1

signal golly_damaged(amount: int)

var patrolSpeed = 50
var chaseSpeed = 100

var cooldown = true


func _physics_process(delta: float) -> void: 
	if curr_attacking: 
		move_and_slide()
		return
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
		curr_attacking = true
		cooldown = false
		cooldown_timer.start()

		velocity.x = 0

		var attacks = ["attack1", "attack2"]
		var chosen = attacks.pick_random()
		if chosen == "attack1": damage = 25
		else: damage = 50

		golly.play(chosen)

func take_damage(_amount):
	if dying:
		return

	health -= 25
	golly_damaged.emit(25)
	hurt_sfx.play()
	
	if health <= 0:
		if GameManager.curr_level != 5:
			var key = key_scene.instantiate()
			get_parent().add_child(key)
			key.global_position = Vector2(global_position.x, global_position.y+20)
		queue_free()
	
	golly.modulate = Color(18.892, 18.892, 18.892, 1.0)
	damage_cooldown.start()

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
		if golly.frame == 6:
			attack_sfx.play()
			if target != null and attack:
				target.take_damage(damage, global_position)
	elif golly.animation == "chase" or golly.animation == "move":
		if golly.frame == 6:
			walk_sfx.play()
		
func _on_cooldown_timer_timeout() -> void:
	cooldown = true

func _on_golly_animation_finished() -> void:
	if golly.animation.begins_with("attack"):
		curr_attacking = false
func _on_damage_cooldown_timeout() -> void:
	golly.modulate = Color(1.0, 1.0, 1.0, 1.0)
