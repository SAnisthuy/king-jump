extends CharacterBody2D
var SPEED = 100
var JUMP_VELOCITY = -250
var attacking = false
var dying = false
var knockback_timer = 0.0
var knockback_velocity = 0

var can_jump = true
var in_air = false
var can_use_shield = true

var mult = 60
var attack_cooldown = 0.0


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox: Area2D = $"player hitbox"
@onready var spear: Marker2D = $spear
@onready var damage_cooldown: Timer = $damage_cooldown
@onready var coyote_time: Timer = $"coyote time"

@onready var attack_sfx: AudioStreamPlayer = $attackSFX
@onready var walk_sfx: AudioStreamPlayer = $walkSFX
@onready var ground_impact_sfx: AudioStreamPlayer = $groundImpactSFX
@onready var damage_sfx: AudioStreamPlayer = $damageSFX
@onready var block_sfx: AudioStreamPlayer = $blockSFX
@onready var break_sfx: AudioStreamPlayer = $breakSFX

var restart_screen = preload("res://Scenes/restart_menue.tscn")


func _physics_process(delta: float) -> void:
	if GameManager.player_health <= 0 and !dying:
		_on_health_dead()
		damage_sfx.play()
		return
	GameManager.player_pos = global_position
	GameManager.player_attack_cooldown = attack_cooldown * mult
	SPEED = 100
	var direction = 1
	if can_jump == false and is_on_floor():
		can_jump = true
		
	if not is_on_floor():
		velocity += get_gravity() * delta
		in_air = true
	
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
		
		
	if knockback_timer > 0:
		knockback_timer -= delta

		velocity.x = knockback_velocity
		knockback_velocity = move_toward(knockback_velocity, 0, 1000 * delta)

		move_and_slide()
		return
	
	if Input.is_action_just_pressed("drop"):
		var dropped_item = Inventory.drop_item(Inventory.selected_slot)
		if dropped_item != null:
			get_parent().add_child(dropped_item)
			dropped_item.global_position = Vector2(global_position.x, global_position.y)
		
	if Input.is_action_just_pressed("jump") and can_jump:
		jump()
	
	if (is_on_floor() == false) and can_jump and coyote_time.is_stopped():
		coyote_time.start()
		
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
			attack_sfx.play()
		else: pass
		
	elif Input.is_action_pressed("forward"):
		if Input.is_action_pressed("sprint"):
			if holding_shield():
				animated_sprite_2d.play("s_walk")
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
				animated_sprite_2d.play("s_walk")
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

func _on_area_2d_body_entered(_body: Node2D) -> void:
	_on_health_dead()

func player(): #makes sure player is recognizable to others
	pass

func _on_health_dead():
	dying = true
	animated_sprite_2d.play("death")
	Inventory.clear()
	
func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation.begins_with("attack"):
		attacking = false
	if animated_sprite_2d.animation == "death":
		GameManager.player_health = 100
		Collectables.update_vals()
		if GameManager.auto_restart:
			get_tree().reload_current_scene()
		else:
			var inst_res = restart_screen.instantiate()
			get_tree().root.add_child(inst_res)
			get_tree().paused = true

func damage_enemy():
	for body in hitbox.get_overlapping_bodies():
		if body.has_method("enemy"):
			body.take_damage(50)

func jump():
	velocity.y = JUMP_VELOCITY
	can_jump = false

func _on_animated_sprite_2d_frame_changed() -> void:
	if animated_sprite_2d.animation.begins_with("attack"):
		if animated_sprite_2d.frame < 6:
			can_use_shield = false
		else:
			can_use_shield = true
		attack_cooldown -= 0.1
		if animated_sprite_2d.frame == 2:
			damage_enemy()
	
	if animated_sprite_2d.animation == "walk":
		if animated_sprite_2d.frame == 1 or animated_sprite_2d.frame == 3:
			walk_sfx.play()
	if animated_sprite_2d.animation == "sprint":
		if animated_sprite_2d.frame == 2 or animated_sprite_2d.frame == 5:
			walk_sfx.play()

func take_damage(amount:int, pos):
	if holding_shield():
		Inventory.shield -= 1
		if Inventory.shield <= 0:
			Inventory.shield = null
			break_sfx.play()
		else:
			block_sfx.play()
	else:
		GameManager.player_health -= amount
		if GameManager.player_health <= 0:
			_on_health_dead()
		animated_sprite_2d.modulate = Color(18.892, 18.892, 18.892, 1.0)
		damage_cooldown.start()
		damage_sfx.play()
		knockback(pos)
		
func holding_shield():

	return Inventory.shield != null and Input.is_action_pressed("block") and can_use_shield

func holding_spear():
	var item = Inventory.inventory[Inventory.selected_slot]

	return item != null and item["name"] == "spear"

func holding_sword():
	var item = Inventory.inventory[Inventory.selected_slot]
	return item != null and item["name"] == "sword"

func _on_damage_cooldown_timeout() -> void:
	animated_sprite_2d.modulate = Color(1.0, 1.0, 1.0, 1.0)

func _on_coyote_time_timeout() -> void:
	can_jump = false

func _on_animated_sprite_2d_animation_changed() -> void:
	if animated_sprite_2d == null: return
	if animated_sprite_2d.animation == "attack1":
		attack_cooldown = 1.1
		mult = 60
	elif animated_sprite_2d.animation == "attack2":
		attack_cooldown = 0.7
		mult = 94.2857142857

func knockback(pos):
	var dir = sign(global_position.x - pos.x)

	knockback_velocity = dir * 100
	knockback_timer = 0.2
