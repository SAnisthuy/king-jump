extends CharacterBody2D

# connections
@onready var health: ProgressBar = $health
@onready var sprite: AnimatedSprite2D = $sprite
@onready var attack_cooldown: Timer = $"attack cooldown"
@onready var damage: Timer = $damage
@onready var range_atack: Timer = $"range atack"

#Audio
@onready var attack_2: AudioStreamPlayer = $audio/Attack2
@onready var attack_1: AudioStreamPlayer2D = $audio/Attack1
@onready var deathSFX: AudioStreamPlayer = $audio/death
@onready var walkSFX: AudioStreamPlayer = $audio/walk
@onready var ambiance: AudioStreamPlayer = $audio/ambiance


var throwable = preload("res://Scenes/skull_throwable.tscn")
var end_scene = preload("res://Scenes/end_scene.tscn")

# variables

const SPEED = 0.8 # inversely related to velocity

var player_pos: Vector2
var player: Node2D

var attack_available_m = true # melee
var attack_available_r = true # range

# states
var attack = false
var chase = false
var patrol = true
var higher = false
var phase_two = false
var dying = false

# substates
var range_a = false
var melee = true

# detections
var in_range_attack = false
var in_range_detect = false

func _physics_process(_delta: float):
	player_pos = GameManager.player_pos
	if dying: #MAKE SURE THAT IF DYING HE ACTUALLY DIES INSTEAD OF SWITCHING STATES
		return
	if attack: # ENSURE THE ATTACK ANIMATION GOES THROUGH
		return

	# MANAGES WHAT TYPE OF ATTACK IS HAPPENING
	if health.value < (health.max_value / 2) and !phase_two:
		enter_phase_two()
		return

	if in_range_detect and !in_range_attack and !range_a: # IF THE PLATYER IN THE DETECTION RANGE AND NOT IN ATTACK RANGE
		chase = true
		chasing()
		
	if in_range_attack and attack_available_m and melee and !range_a: # IF THE PLAYER IN IS IN THE RANGE OF ATTACK AND HAS ATTACK AVAILABLE
		chase = false
		attack = true
		melee_attack()
	
	if range_a and attack_available_r:
		range_attack()
	
	move_and_slide()
		
# state functions
func range_attack():
	var skull = throwable.instantiate()
	skull.body = player
	skull.global_position = $Node2D.global_position
	get_tree().current_scene.add_child(skull)
	range_atack.start()
	attack_available_r = false
	sprite.play("spawn")
	attack_2.play()
	
func melee_attack():
	velocity = Vector2.ZERO
	sprite.play("attack")
	
func chasing():
	if phase_two:
		return
	var dist = (player_pos.x - global_position.x)
	var dir = sign(dist)
		
	velocity.x = dist / SPEED
	
	if (dist > 20 or dist < -20):
		if dir < 0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
			
	if abs(dist) < 10:
		sprite.play("idle")
	else:
		sprite.play("walk")
					
func enter_phase_two():
	phase_two = true
	
	velocity = Vector2.ZERO
	sprite.play("jump")
	var tween = create_tween()	
	tween.tween_property(
		self,
		"global_position",
		Vector2(222.0, -382.0),
		2.0
	)

	await tween.finished

	higher = true
	range_a = true
	melee = false

func death():
	dying = true
	sprite.play("death")
	deathSFX.play()

# Necessary functions
func enemy(): pass

func take_damage(amount: int):
	health.value -= amount
	if health.value <= 0:
		death()
	else:
		sprite.modulate = Color(4.33, 4.33, 4.33, 1.0)
		damage.start()
	
# Detection range functions
func _on_detection_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player = body
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

func _on_sprite_animation_finished() -> void:
	if sprite.animation == "attack":
		attack = false
		attack_available_m = false
		attack_cooldown.start()
	if sprite.animation == "jump":
		sprite.play("idle")
	if sprite.animation == "death":
		get_tree().change_scene_to_packed(end_scene)
		queue_free()
		
func _on_attack_cooldown_timeout() -> void:
	attack_available_m = true

func _on_sprite_frame_changed() -> void:
	if sprite == null:
		return
	if sprite.animation == "attack" and sprite.frame == 6:
		if in_range_attack:
			player.take_damage(20)
		attack_1.play()
	if sprite.animation == "walk" and sprite.frame in [0, 5]:
		walkSFX.play()
		
func _on_damage_timeout() -> void:
	sprite.modulate = Color(1.0, 1.0, 1.0, 1.0)

func _on_range_atack_timeout() -> void:
	attack_available_r = true


func _on_ambiance_time_timeout() -> void:
	ambiance.play()
