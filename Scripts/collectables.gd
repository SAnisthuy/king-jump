extends Node

var required = [null, 
{"skulls": null, "coins": 4}, # Level 1
{"skulls": null, "coins": 5}, # level 2
{"skulls": 1, "coins": 3},  # Level 3
{"coins": 12, "skulls": 3}]	# Level 4


var coins = required[GameManager.curr_level]["coins"]
var skulls = required[GameManager.curr_level]["skulls"]


func update_vals():
	coins = required[GameManager.curr_level]["coins"]
	skulls = required[GameManager.curr_level]["skulls"]
