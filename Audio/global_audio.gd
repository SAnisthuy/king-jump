extends Node
@onready var button_click: AudioStreamPlayer = $button_click
@onready var collect_sfx: AudioStreamPlayer = $collectSFX

func play_button_click():
	button_click.play()
	await button_click.finished
	return

func collect_play():
	collect_sfx.play()
