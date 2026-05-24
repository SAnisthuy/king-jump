extends CharacterBody2D

var health = 100
signal skeley_damaged(damage:int)
var dying = false

var is_in_pursuit = false
const speed = 100
var target = null

const patrol_speed = 10
var direction = 1
@onready var path_follow: PathFollow2D = get_parent() as PathFollow2D

var attacking = false
var cooldown = true
var player_in_range = false
@onready var attack_cooldown: Timer = $attack_cooldown
@onready var wall_check: RayCast2D = $WallCheck
@onready var floor_check: RayCast2D = $FloorCheck
@onready var skeley: AnimatedSprite2D = $AnimatedSprite2D

var skull_scene = preload("res://Scenes/skull.tscn")


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
		patrol()

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

	if skeley.animation != "chase":
		skeley.play("chase")

func patrol():

	velocity.x = direction * patrol_speed

	skeley.flip_h = direction < 0

	if wall_check.is_colliding():
		turn_around()

	if !floor_check.is_colliding():
		turn_around()

	if skeley.animation != "walk":
		skeley.play("walk")

func turn_around():

	direction *= -1

	floor_check.target_position.x *= -1
	wall_check.target_position.x *= -1

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
			patrol()
	if skeley.animation == "death":
		var skull = skull_scene.instantiate()
		get_parent().add_child(skull)
		skull.global_position = global_position
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
			patrol()

func _on_animated_sprite_2d_frame_changed() -> void:
		if skeley.animation == "attack":
			if skeley.frame == 7 and player_in_range and target != null:
				target.take_damage(25)

func take_damage(amount):
	if dying:
		return

	health -= 25
	skeley_damaged.emit(25)

	if health <= 0:
		dying = true
		skeley.play("death")

		
			
