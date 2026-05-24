extends CharacterBody2D
signal death
var SPEED = 100
var JUMP_VELOCITY = -250
var attacking = false
var dying = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox: Area2D = $"player hitbox"
@onready var spear: Marker2D = $spear

func _physics_process(delta: float) -> void:
	SPEED = 100
	var direction = 1
	if not is_on_floor():
		velocity += get_gravity() * delta
	if holding_shield():
		JUMP_VELOCITY = -100
	if !holding_shield():
		JUMP_VELOCITY = -250
	if dying:
		return
	if attacking:
		velocity.x = 0 
		move_and_slide()
		return
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
			
	elif Input.is_action_just_pressed("attack"):
		if holding_shield():
			pass
		if holding_spear():
			spear.fire()
		if holding_sword():
			attacking = true
			var my_list = ["attack1", "attack2"]
			var attack = my_list.pick_random()
			animated_sprite_2d.play(attack)
		else: pass
		
	elif Input.is_action_pressed("forward"):
		if Input.is_action_pressed("sprint"):
			if holding_shield():
				pass
			else: 
				animated_sprite_2d.play("sprint")
				SPEED = 150
		else:
			SPEED = 100
			if holding_shield():
				animated_sprite_2d.play("s_walk")
			else: animated_sprite_2d.play("walk")
		direction = 1
		animated_sprite_2d.flip_h = false
		velocity.x = direction * SPEED
		
	elif Input.is_action_pressed("backward"):
		if Input.is_action_pressed("sprint"):
			if holding_shield():
				pass
			else: 
				animated_sprite_2d.play("sprint")
				SPEED = 150
		else:
			SPEED = 100
			if holding_shield():
				animated_sprite_2d.play("s_walk")
			else: animated_sprite_2d.play("walk")
		direction = -1
		animated_sprite_2d.flip_h = true
		velocity.x = direction * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if holding_shield():	
			animated_sprite_2d.play("s_idle")
		else: animated_sprite_2d.play("idle")
		
		
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	_on_health_dead()

func player(): #makes sure player is recognizable to others
	pass

func _on_health_dead():
	dying = true
	animated_sprite_2d.play("death")
	death.emit()

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation.begins_with("attack"):
		attacking = false

func damage_enemy():
	for body in hitbox.get_overlapping_bodies():
		if body.has_method("enemy"):
			body.take_damage(50)

func _on_animated_sprite_2d_frame_changed() -> void:
	if animated_sprite_2d.animation.begins_with("attack"):
		if animated_sprite_2d.frame == 2:
			damage_enemy()

func take_damage(amount:int):
	
	if holding_shield():
		var item = Inventory.inventory[Inventory.selected_slot]
		item["health"] -= 1
		if item["health"] <= 0:
			Inventory.inventory[Inventory.selected_slot] = null
	else: 
		GameManager.player_health -= amount

func holding_shield():

	var item = Inventory.inventory[Inventory.selected_slot]

	return item != null and item["name"] == "shield"

func holding_spear():
	var item = Inventory.inventory[Inventory.selected_slot]

	return item != null and item["name"] == "spear"

func holding_sword():
	var item = Inventory.inventory[Inventory.selected_slot]
	return item != null and item["name"] == "sword"
