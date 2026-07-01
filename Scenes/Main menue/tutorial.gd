extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var scene_1: Control = $"Scene 1"
@onready var scene_2: Control = $"Scene 2"
@onready var press_enter: Label = $"Press Enter"

var level = preload("res://Scenes/level_1.tscn")
var state = 0
@onready var scene_3: Control = $"Scene 3"
@onready var timer: Timer = $Timer

func _ready() -> void:
	scene_2.visible = false
	press_enter.visible = false
	scene_3.visible = false
	timer.start()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept") and state == 2 and press_enter.visible:
		get_tree().change_scene_to_packed(level)
		GameManager.opening_tut = true
	if Input.is_action_just_pressed("ui_accept") and press_enter.visible:
		GlobalAudios.play_button_click()
		press_enter.visible = false
		if state == 0:
			animation_player.play("Transition")
			scene_2.visible = true
		elif state == 1:
			scene_3.visible = true
			animation_player.play("Transition 2")
		state += 1

func _on_timer_timeout() -> void:
	press_enter.visible = true

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Transition":
		timer.start()
	elif anim_name == "Transition 2":
		timer.start()
