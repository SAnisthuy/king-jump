extends Node2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer


var play_in_range = false
var attacking  = false

func _ready() -> void:
	sprite.play("idle")




func _on_area_2d_body_entered(body: Node2D) -> void:
	play_in_range = true
	try_attack()


func _on_area_2d_body_exited(body: Node2D) -> void:
	play_in_range  = false


func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation.begins_with("attack"):
		attacking = false
		if play_in_range:
			timer.start()
		else:
			sprite.play("idle")

func try_attack():
	if attacking: 
		return
	if !play_in_range:
		sprite.play("idle")
		return
	
	attacking = true
	
	var my_list = ["attack 1", "attack 2", "attack 3"]
	var attack = my_list.pick_random()
	GameManager.player_health -= 25
	sprite.play(attack)


func _on_timer_timeout() -> void:
	if play_in_range:
		try_attack()
	else:
		sprite.play("idle")


func _on_player_attacked() -> void:
	if play_in_range:
		queue_free()
