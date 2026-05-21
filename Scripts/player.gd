extends CharacterBody2D
signal death()
var SPEED = 100
var JUMP_VELOCITY = -250
var attacking = false
var dying = false
signal attacked
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_cooldown: Timer = $"attack cooldown"

func _process(delta: float) -> void:
	var direction = 1
	if !dying:
		
		if not is_on_floor():
			velocity += get_gravity() * delta
				
		if attacking:
			return
	
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			
		elif Input.is_action_just_pressed("attack"):
			attacked.emit()
			attacking = true
			animated_sprite_2d.play("attack")
		
		elif Input.is_action_pressed("forward"):
			if Input.is_action_pressed("sprint"):
				SPEED = 150
				animated_sprite_2d.play("sprint")
			else:
				SPEED = 100
				animated_sprite_2d.play("walk")
			direction = 1
			animated_sprite_2d.flip_h = false
			velocity.x = direction * SPEED
		
		elif Input.is_action_pressed("backward"):
			direction = -1
			if Input.is_action_pressed("sprint"):
				SPEED = 150
				animated_sprite_2d.play("sprint")
			else:
				SPEED = 100
				animated_sprite_2d.play("walk")
			animated_sprite_2d.flip_h = true
			velocity.x = direction * SPEED
		
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)	
			animated_sprite_2d.play("idle")
		
		
		move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	GameManager.player_health = 0

func player(): #makes sure player is recognizable to others
	pass

func _on_health_dead() -> void:
	dying = true
	animated_sprite_2d.play("death")
	death.emit()

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "attack":
		attacking = false

# ATTACKING
func enemy_attack():
	GameManager.player_health -= 10
