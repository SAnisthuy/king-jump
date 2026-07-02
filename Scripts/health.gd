extends ProgressBar

var animating = false

func _process(_delta):
	if !animating:
		value = GameManager.player_health
	
func heal(amount: int):
	animating = true
	if GameManager.player_health + amount > 100:
		amount = 100 - GameManager.player_health
	GameManager.player_health += amount
	
	modulate = Color(0.5, 1.3, 0.5)
	GlobalAudios.heal_sfx.play()
	var tween = create_tween()
	tween.tween_property(self, "value", GameManager.player_health, 0.5)
	await tween.finished
	modulate = Color(1.0, 1.0, 1.0, 1.0)
	animating = false
