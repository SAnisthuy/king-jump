extends Node

var required = [null, {"skulls": null, "coins": 4}, {"skulls": null, "coins": 10}, {"skulls": 1, "coins": 3}]


var coins = required[GameManager.curr_level]["coins"]
var skulls = required[GameManager.curr_level]["skulls"]


func update_vals():
	coins = required[GameManager.curr_level]["coins"]
	skulls = required[GameManager.curr_level]["skulls"]
