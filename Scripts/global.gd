extends Node

var player_health = 100
var player_pos: Vector2
var player: CharacterBody2D

var levels = [null, "res://Scenes/level_1.tscn", 
					"res://Scenes/level_2.tscn", 
					"res://Scenes/level_3.tscn",
					"res://Scenes/level_4.tscn",
					"res://Scenes/necromancers_lair.tscn"]
var curr_level = 1

var doors = [null, Vector2(312, 68), Vector2(-128, 110), Vector2(816, -186), Vector2(184, -175), Vector2(224, -384)]

var auto_restart = false
var auto_switch_sword = true
var player_attack_cooldown = 60 #seconds

var tut = {"golem": false, "skeleton_easy": false, "skeleton_hard": false, "gollux": false}
var opening_tut = false

var healing = false
