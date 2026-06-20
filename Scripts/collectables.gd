extends Node

var required = [null, 
{"skulls": null, "coins": 1}, # Level 1
{"skulls": null, "coins": 2}, # level 2
{"skulls": 1, "coins": 3},  # Level 3
{"coins": 5, "skulls": 3}, # Level 4
{"coins": 0, "skulls": 0}]	#level 5


var coins = required[GameManager.curr_level]["coins"]
var skulls = required[GameManager.curr_level]["skulls"]


func update_vals():
	coins = required[GameManager.curr_level]["coins"]
	skulls = required[GameManager.curr_level]["skulls"]
