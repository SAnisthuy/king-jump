extends ProgressBar

signal dead()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var health = GameManager.player_health
	value = health
	if value == 0:
		dead.emit()
