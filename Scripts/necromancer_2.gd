extends CharacterBody2D

# connections
@onready var health: ProgressBar = $health
@onready var sprite: AnimatedSprite2D = $sprite

# variables

const SPEED = 1 # inversely related to velocity

var player_pos: Vector2
var attack_available_m = true # melee
var attack_available_r = true # range

# states
var attack = false
var chase = false
var patrol = true

# substates
var range = false
var melee = false

# detections
var in_range_attack = false
var in_range_detect = false

func _physics_process(delta: float):
	player_pos = GameManager.player_pos
	if health.value < (health.max_value / 2):
		range = true
		melee = false
	else:
		range = false
		melee = true
	
	if in_range_detect and !in_range_attack:
		chase = true
		chasing()
		
		
	if in_range_attack and attack_available_m:
		chase = false
		attack = true
		melee_attack()
	
	move_and_slide()
		
		
	
# state functions
func range_attack():
	pass
	
func melee_attack():
	velocity = Vector2.ZERO
	sprite.play("attack")
	
func chasing():
	var dist = (player_pos.x - global_position.x)
	var dir = sign(dist)
	
	velocity.x = dist / SPEED
	
	if (dist > 20 or dist < -20):
		if dir < 0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
			
	

func jump():
	pass

func death():
	pass

# Necessary functions
func enemy(): pass

func take_damage(amount: int):
	health.value -= amount
	if health.value <= 0:
		death()
		
	

# Detection range functions
func _on_detection_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		in_range_detect = true

func _on_detection_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		in_range_detect = false
		
# Attack range functions
func _on_attack_range_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		in_range_attack = true

func _on_attack_range_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		in_range_attack = false
