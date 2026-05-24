extends Node

var inventory = [{"name": "sword"},
	null,
	{"name":"spear", 
	"health": 5},
	null
]

var selected_slot = 0

func add_item(item_data):
	for i in range(inventory.size()):
		if inventory[i] == null:
			inventory[i] = item_data
			return true
	return false

func clear():
	for i in range(inventory.size()):
		inventory[i] = null
