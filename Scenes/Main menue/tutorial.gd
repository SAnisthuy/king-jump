extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var scene_1: Control = $"Scene 1"
@onready var scene_2: Control = $"Scene 2"

var level = preload("res://Scenes/level_1.tscn")
var state = 0

func _ready() -> void:
	scene_2.visible = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept") and state == 1:
		get_tree().change_scene_to_packed(level)
	if Input.is_action_just_pressed("ui_accept"):
		animation_player.play("Transition")
		scene_2.visible = true
		state += 1
