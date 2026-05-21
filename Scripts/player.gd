extends CharacterBody2D

var dead = 1
var SPEED = 100
var JUMP_VELOCITY = -250
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _process(delta: float) -> void:
	var direction = 1
	if not is_on_floor() and position.y < 223:
		velocity += get_gravity() * delta * dead
			
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
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
	print("hi")
	animated_sprite_2d.play("death")
