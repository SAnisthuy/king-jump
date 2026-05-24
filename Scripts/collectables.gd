extends Node

var required = [null, {"skulls": null, "coins": 4}, {"skulls": null, "coins": 5}, {"skulls": 1, "coins": 3}, {"coins": 1, "skulls": 1}]


var coins = required[GameManager.curr_level]["coins"]
var skulls = required[GameManager.curr_level]["skulls"]


func update_vals():
	coins = required[GameManager.curr_level]["coins"]
	skulls = required[GameManager.curr_level]["skulls"]
