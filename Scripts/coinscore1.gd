extends Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Collectables.skulls != null:
		text = "Coins needed: %d\nSkulls needed: %d" % [Collectables.coins, Collectables.skulls]
	else: text = "Coins needed: " + str(Collectables.coins)
	
		
