extends Node
@onready var button_click: AudioStreamPlayer = $button_click
@onready var collect_sfx: AudioStreamPlayer = $collectSFX
@onready var key_sfx: AudioStreamPlayer = $keySFX

func play_button_click():
	button_click.play()

func collect_play():
	collect_sfx.play()
	
func collect_key_play():
	key_sfx.play()
