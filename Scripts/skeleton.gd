extends CharacterBody2D

var spear_scene =  preload("res://Scenes/spear.tscn")

var health = 100
signal skeley_damaged(damage:int)
var dying = false

var is_in_pursuit = false
const speed = 50
var target = null

var attacking = false
var cooldown = true
var player_in_range = false


@onready var damage_cooldown: Timer = $damage_cooldown

@onready var attack_cooldown: Timer = $attack_cooldown

@onready var skeley: AnimatedSprite2D = $AnimatedSprite2D



func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if dying:
		return
	
	if attacking:
		move_and_slide()
		return

	if player_in_range and cooldown:
		start_attack()
		move_and_slide()
		return

	if is_in_pursuit and target:
		chase_player()
	else:
		idle()

	move_and_slide()

func start_attack():
	attacking = true
	cooldown = false

	if skeley.animation != "attack":
		velocity.x = 0
		skeley.play("attack")

func chase_player():

	var dist = target.position.x - position.x

	skeley.flip_h = dist < 0

	velocity.x = sign(dist) * speed

	if skeley.animation != "walk":
		skeley.play("walk")

func idle():

	velocity.x = 0

	if skeley.animation != "idle":
		skeley.play("idle")

func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		target = body
		is_in_pursuit = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == target:
		target = null
		is_in_pursuit = false

func enemy():
	pass

func _on_animated_sprite_2d_animation_finished() -> void:
	if skeley.animation.begins_with("attack"):

		attacking = false
		attack_cooldown.start()

		if !player_in_range and !is_in_pursuit:
			idle()
	if skeley.animation == "death":
		if randi() % 2 == 0:
			var spear = spear_scene.instantiate()
			get_parent().add_child(spear)
			spear.global_position = global_position
		queue_free()

func _on_enemy_hit_box_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_range = true

func _on_attack_cooldown_timeout() -> void:
	cooldown = true

func _on_enemy_hit_box_body_exited(body):

	if body.has_method("player"):
		player_in_range = false

		if !attacking and !is_in_pursuit:
			idle()

func _on_animated_sprite_2d_frame_changed() -> void:
		if skeley.animation == "attack":
			if skeley.frame == 7 and target:
				target.take_damage(10)

func take_damage(amount):
	if dying:
		return
	
	health -= 25
	skeley_damaged.emit(25)
	if health <= 0:
		dying = true
		if skeley.animation != "death":
			skeley.play("death")
	skeley.modulate = Color(18.892, 18.892, 18.892, 1.0)
	damage_cooldown.start()

func _on_damage_cooldown_timeout() -> void:
	skeley.modulate = Color(1.0, 1.0, 1.0, 1.0)
