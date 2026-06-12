extends Node2D

var levelDefs = [["sword"], ["sword"], ["sword", "spear"], ["sword", "spear", "shield"]]

var inventory = [{"name": "sword", "health": 5},
	null,
	null,
	null
]

var items = {"spear": preload("res://Scenes/spear.tscn"), "shield": preload("res://Scenes/shield.tscn") ,"key": preload("res://Scenes/key.tscn")}

var item_map = {"shield": 0, "spear": 1, "sword": 2}

var item_info = [{"name": "shield","health": 5},
				{"name": "spear", "health": 5},
				{"name": "sword", "health": 5}]

var selected_slot = 0

func add_item(item_data):
	for i in range(inventory.size()):
		if inventory[i] == null:
			inventory[i] = item_data.duplicate()
			return true
	return false

func clear():
	for i in range(inventory.size()):
			inventory[i] = null
	for item in levelDefs[GameManager.curr_level - 1]:
		add_item(item_info[item_map[item]])
	
func drop_item(slot_num):
	if slot_num != 0 and inventory[slot_num] != null:
		var item_name = inventory[slot_num]["name"]
		var health_data = inventory[slot_num]["health"]
		inventory[slot_num] = null
		var removed_item =  items[item_name].instantiate()
		removed_item.health = health_data
		return removed_item
		
func remove_item(item_name):
	for i in range(inventory.size()):
		if inventory[i] != null:
			if inventory[i]["name"] == item_name:
				inventory[i] = null
