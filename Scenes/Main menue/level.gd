extends Label


#Manage what the level name is
var levels = [null, "The Storehouse", "The Great Halls", "The Bone Passage", "The Gloam Depths", "The Necromancer's Lair"]

func _ready() -> void:
	await get_tree().process_frame
	text = levels[GameManager.curr_level]
