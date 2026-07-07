extends CanvasLayer

@onready var best_score: Label = $"Control/HBoxContainer/best score"
@onready var time: Label = $Control/HBoxContainer/Time

@onready var sec_1: VBoxContainer = $Control/HBoxContainer/HBoxContainer/Sec1
@onready var sec_2: VBoxContainer = $Control/HBoxContainer/HBoxContainer/Sec2
@onready var sec_3: VBoxContainer = $Control/HBoxContainer/HBoxContainer/Sec3
@onready var sec_4: VBoxContainer = $Control/HBoxContainer/HBoxContainer/Sec4
@onready var sec_5: VBoxContainer = $Control/HBoxContainer/HBoxContainer/Sec5

var main_menu = preload("res://Scenes/Main menue/main_menue.tscn")

@onready var sectors = {sec_1: TimerGlobal.sector1, 
				sec_2: TimerGlobal.sector2, 
				sec_3: TimerGlobal.sector3, 
				sec_4: TimerGlobal.sector4, 
				sec_5: TimerGlobal.sector5}

func _ready() -> void:
	#MANAGE MAIN TIME
	TimerGlobal.timing = false
	var curr_time = TimerGlobal.get_time()
	var frame_total = TimerGlobal.get_frames()
	if frame_total < GameManager.best_score:
		GameManager.best_score = frame_total
		best_score.visible = true
	else:
		best_score.visible = false
	
	time.text = "%02d:%02d:%02d" % curr_time
	
	#MANAGE SEPERATE SECTOR TIMING
	var i = 0
	for sector in sectors:
		sector.get_node("Label").text = TimerGlobal.frames_to_string(sectors[sector])
		
		var difference = TimerGlobal.frames_to_string(abs(sectors[sector] - GameManager.sectors_bests[i]))
		if GameManager.sectors_bests[i] == INF:
			difference = "00:00:00"
		if sectors[sector] < GameManager.sectors_bests[i]:
			sector.get_node("Sector").texture.gradient.set_color(0, Color(0.42, 0.0, 0.512, 1.0))
			GameManager.sectors_bests[i] = sectors[sector]
			sector.get_node("Diff").text = "-" + difference
			sector.get_node("Diff").modulate = Color(0.024, 0.633, 0.048, 1.0) 
		else:
			
			sector.get_node("Diff").text = "+" + difference
			sector.get_node("Sector").texture.gradient.set_color(0, Color(0.512, 0.368, 0.0, 1.0))
			sector.get_node("Diff").modulate = Color(0.836, 0.0, 0.08, 1.0) 
		i += 1
func _on_button_pressed() -> void:
	get_tree().call_deferred("change_scene_to_packed", main_menu)
