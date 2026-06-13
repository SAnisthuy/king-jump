extends Marker2D

@onready var timer: Timer = $Timer

var spear_path = preload("res://Scenes/throwable.tscn")
@onready var spear_sfx: AudioStreamPlayer = $"../spearSFX"
var cooldown = false

func _process(_delta):
	visible = holding_spear()
	look_at(get_global_mouse_position())
	

func fire():
	if !cooldown:
		var spear = spear_path.instantiate()

		spear.global_position = $Node2D.global_position
		spear.dir = global_rotation
		spear.rotation = global_rotation
	
		get_tree().current_scene.add_child(spear)
		spear_sfx.play()
		cooldown = true
		#take health off the spear
		var item = Inventory.inventory[Inventory.selected_slot]
		item["health"] -= 1
		if item["health"] <= 0:
			Inventory.inventory[Inventory.selected_slot] = null
		
		timer.start()
		
	
	
func holding_spear():
	var item = Inventory.inventory[Inventory.selected_slot]
	return item != null and item["name"] == "spear"


func _on_timer_timeout() -> void:
	cooldown = false
