extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

#player related stuff
var player = null
var player_in_range = false

#states
var attacking = false
var dying = false

var cooldown = true

@onready var damage: Timer = $damage
@onready var sprite: AnimatedSprite2D = $sprite
@onready var health: ProgressBar = $health
@onready var attack_cooldown: Timer = $"attack cooldown"
@onready var detection: Area2D = $detection


var throwable = preload("res://Scenes/skull_throwable.tscn")

func _physics_process(delta: float) -> void:

	if attacking or dying:
		return
	if player_in_range and cooldown:
		if sprite.animation != "attack":
			sprite.play("attack")
	else:
		sprite.play("idle")

func attack():
	attacking = true

	
	throw_skull()
	
	cooldown = false
	attack_cooldown.start()

func throw_skull():
	var skull = throwable.instantiate()
	skull.body = player
	skull.global_position = $Node2D.global_position
	get_tree().current_scene.add_child(skull)	

func _on_detection_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player = body
		player_in_range = true

func _on_detection_body_exited(body):
	if body.has_method("player"):
		player = null
		player_in_range = false

func _on_attack_cooldown_timeout() -> void:
	cooldown = true

func enemy():
	pass

func take_damage(amount:int):
	if dying: return
	health.value -= amount
	if health.value <= 0:
		sprite.play("death")
		dying = true
		health.visible = false
	else:
		sprite.modulate = Color(4.416, 4.416, 4.416, 1.0)
		damage.start()

func _on_sprite_animation_finished() -> void:
	if sprite.animation == "attack":
		attacking = false
	if sprite.animation == "death":
		death()
		queue_free()

func _on_sprite_frame_changed() -> void:
	if !is_instance_valid(sprite):
		return

	if dying:
		return

	if sprite.animation == "attack" and sprite.frame == 32:
		attack()

func _on_damage_timeout() -> void:
	sprite.modulate = Color(1.0, 1.0, 1.0, 1.0)

func death():
	for body in detection.get_overlapping_bodies():
		if body.has_method("enemy"):
			body.take_damage(1000)
