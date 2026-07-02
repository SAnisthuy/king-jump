extends CanvasLayer

var inventory = Inventory.inventory
var shield_help_needed = true
var selected_slot = Inventory.selected_slot
@onready var shield_help: Label = $shield_help

@onready var slots = [
	$Slots/Slot1,
	$Slots/Slot2,
	$Slots/Slot3,
	$Slots/Slot4
	]
	
@onready var shield: Panel = $Slots/Shield

var item_texture  = {
	"bow": preload("res://Assets/Inventory/bow.png"),
	"shield": preload("res://Assets/Inventory/shield.png"),
	"spear": preload("res://Assets/Inventory/spear.png"),
	"sword": preload("res://Assets/Inventory/32 Free Weapon Icons/Icons/sword.png"),
	"key": preload("res://Assets/Inventory/key.png")
}

func update_hotbar():
	var icon = null
	for i in range(slots.size()): #Manage the four slots
		icon = slots[i].get_node("Icon")
		var item = inventory[i]
		if item == null:
			icon.texture = null
		else:
			icon.texture = item_texture[item["name"]]
	
	icon = shield.get_node("Icon")
	if Inventory.shield != null:
		icon.texture = item_texture["shield"]
	else:
		icon.texture = null
	
func _ready():
	pass

func _process(_delta: float):
	selected_slot = Inventory.selected_slot
	if shield_help_needed and Inventory.shield:
		shield_help.visible = true
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

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("block") and Inventory.shield != null:
		shield_help.visible = false
		shield_help_needed = false

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
	var health = null
	for i in range(slots.size()): #shield health
		health = slots[i].get_node("item_health")
		if inventory[i] == null:
			health.visible = false
		else:
			if inventory[i]["health"] < 5:
				health.visible = true
				health.value = inventory[i]["health"] * 20
			else: # set to false so that if full health you dont show the health bar
				health.visible = false
	health = shield.get_node("item_health")
	if Inventory.shield == null: #shield health
		health.visible = false
	else:
		if Inventory.shield < 5:
			health.visible = true
			health.value = Inventory.shield * 20
		else:
			health.visible = false
			
		
		
		
			
			
