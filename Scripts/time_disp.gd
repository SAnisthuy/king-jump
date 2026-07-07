extends Label

@onready var penalty_disp: Label = $"../PenaltyDisp"

func _process(_delta: float) -> void:
	var curr_time = TimerGlobal.get_time()
	text = "%02d:%02d:%02d" % curr_time
	if TimerGlobal.penalty:
		penalty()
	
func penalty():
	penalty_disp.penalty()
	TimerGlobal.penalty = false
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property(self, "modulate", Color(0.919, 0.003, 0.001, 1.0), 0.4)
	tween.chain().tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 1.0), 0.4)
