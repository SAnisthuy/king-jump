extends Node

var levelDefs = [["sword"], ["sword"], ["sword", "spear"], ["sword", "spear", "shield"]]

var inventory = [{"name": "sword"},
	null,
	null,
	null
]

var item_map = {"shield": 0, "spear": 1, "sword": 2}

var item_info = [{"name": "shield","health": 5},
				{"name": "spear", "health": 5},
				{"name": "sword", "health": INF}]

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
	
