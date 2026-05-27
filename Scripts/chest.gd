extends Area2D

var in_range = false
var opening = false

@onready var chest_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var cooldown: Timer = $cooldown

var shield = preload("res://Scenes/shield.tscn")
var spear = preload("res://Scenes/spear.tscn")

var all_items = [spear, shield]
var picked = []

func _ready() -> void:
	for i in range(randi_range(1, 3)):
		picked.append(all_items.pick_random())

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact") and in_range and !opening:
		chest_sprite.play("open")
		opening = true

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		in_range = true

func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		in_range = false

func _on_animated_sprite_2d_animation_finished() -> void:
	if chest_sprite.animation == "open":
		cooldown.start()

func _on_cooldown_timeout() -> void:
	for item in picked:
		var item_ = item.instantiate()
		get_parent().add_child(item_)
		item_.global_position = Vector2(global_position.x + randi_range(-50, 50), global_position.y)

	queue_free()
