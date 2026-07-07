extends Node

var time_elapsed = 0.0

var timing = false
var penalty = false

var sector1 = 0.0
var sector2 = 0.0
var sector3 = 0.0
var sector4 = 0.0
var sector5 = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timing:
		time_elapsed += delta

func get_time():
	@warning_ignore("integer_division")
	var minutes: int = int(time_elapsed) / 60
	var seconds: int = int(time_elapsed) % 60
	# Multiply the remaining decimal by 100 to get two digit milliseconds
	var milliseconds: int = int((time_elapsed - int(time_elapsed)) * 100)
	
	return [minutes, seconds, milliseconds]

func add_time(amount:float):
	time_elapsed += amount

func get_frames():
	return time_elapsed

func frames_to_string(frames:float):
	@warning_ignore("integer_division")
	var minutes: int = int(frames) / 60
	var seconds: int = int(frames) % 60
	# Multiply the remaining decimal by 100 to get two digit milliseconds
	var milliseconds: int = int((frames - int(frames)) * 100)
	
	return "%02d:%02d:%02d" % [minutes, seconds, milliseconds]
	
