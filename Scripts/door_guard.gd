extends Node2D

@onready var doorguy: AnimatedSprite2D = $doorguy
@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var door: AnimatedSprite2D = $door
@onready var dialogue: Label = $dialogue
@onready var dl_timer: Timer = $"dl timer"

var scene_change = preload("res://Scenes/scene_change.tscn")
var player_in = false
var coins = 0
var skulls = 0 

var opening = false

func _ready() -> void:
	dialogue.visible = false
	coins = Collectables.required[GameManager.curr_level]["coins"]
	skulls = Collectables.required[GameManager.curr_level]["skulls"]

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Interact") and player_in:
		if available():
			if opening: 
				return
			opening = true
			open()
		else:
			dl()		

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in = true

func available():
	if coins - Collectables.coins == coins:
		if skulls != null: 
			return skulls - Collectables.skulls == skulls
		return true
	return false
		
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in = false

func next_level():
	get_tree().call_deferred("change_scene_to_packed", scene_change)

func _on_doorguy_animation_finished() -> void:
	next_level()

func open():
	doorguy.play("open")

func dl():
	dialogue.visible = true
	dl_timer.start()
	await dl_timer.timeout
	dialogue.visible = false

func _on_doorguy_frame_changed() -> void:
	if doorguy == null:
		return
	if doorguy.animation == "open" and doorguy.frame == 6:
		door.play("Open")
