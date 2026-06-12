extends Node
var player_health = 100
var next_level = "res://Scenes/level_2.tscn"
var curr_level = 1
var player_pos: Vector2

var doors = [null, Vector2(312, 68), Vector2(-128, 110), Vector2(816, -186), Vector2(184, -175)]
