extends CanvasLayer

var inventory = Inventory.inventory

var selected_slot = 0

@onready var slots = [
	$Slots/Slot1,
	$Slots/Slot2,
	$Slots/Slot3,
	$Slots/Slot4
	]

var item_texture  = {
	"bow": preload("res://Assets/Inventory/bow.png"),
	"shield": preload("res://Assets/Inventory/shield.png"),
	"spear": preload("res://Assets/Inventory/spear.png"),
	"sword": preload("res://Assets/Inventory/32 Free Weapon Icons/Icons/sword.png"),
	"key": preload("res://Assets/Inventory/key.png")
}

func update_hotbar():
	for i in range(slots.size()):
		var icon = slots[i].get_node("Icon")
		var item = inventory[i]
		if item == null:
			icon.texture = null
		else:
			icon.texture = item_texture[item["name"]]
	

func _ready():
	pass

func _process(_delta: float):
	
	update_hotbar()
	
	if Input.is_action_just_pressed("slot_1"):
		selected_slot = 0
	if Input.is_action_just_pressed("slot_2"):
		selected_slot = 1
	if Input.is_action_just_pressed("slot_3"):
		selected_slot = 2
	if Input.is_action_just_pressed("slot_4"):
		selected_slot = 3
	if Input.is_action_just_pressed("scroll down"):
		selected_slot = (selected_slot + 1) % slots.size()
	if Input.is_action_just_pressed("scroll up"):
		selected_slot = (selected_slot - 1 + slots.size()) % slots.size()
		
	update_selection()
	update_item_health()

func update_selection():
	for i in range(slots.size()):
		if  i == selected_slot:
			slots[i].modulate = Color(1, 1, 1)
		else:
			slots[i].modulate = Color(0.5, 0.5, 0.5)
	Inventory.selected_slot = selected_slot

func get_selected_item():
	return inventory[selected_slot]
		
func update_item_health():
	for i in range(slots.size()):
		if inventory[i] == null:
			var health = slots[i].get_node("item_health")
			health.visible = false
		else:
			var health = slots[i].get_node("item_health")
			if inventory[i]["health"] < 5:
				health.visible = true
				health.value = inventory[i]["health"] * 20
			else:
				health.visible = false
			
			
