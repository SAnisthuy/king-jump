extends CanvasLayer
@onready var main: TileMap = $PanelContainer/SubViewportContainer/SubViewport/Main
@onready var camera_2d: Camera2D = $PanelContainer/SubViewportContainer/SubViewport/Camera2D
@onready var knight_icon: Sprite2D = $PanelContainer/SubViewportContainer/SubViewport/KnightIcon

@onready var hide_button: Button = $hide


@onready var coins: Node = $"../mapping/coins"
@onready var gollux: Node = $"../Gollux"
@onready var golem: Node = $"../Golem"
@onready var skeleton_e: Node = $"../SkeletonE"
@onready var skeleton_d: Node = $"../SkeletonD"
@onready var platforms: Node = $"../mapping/platforms"

@onready var main_panel: PanelContainer = $PanelContainer
@onready var secondary_panel: PanelContainer = $PanelContainer2

var hidden = false

const SKELEY_ICON_H = preload("uid://bnplmujg1visa")
const SKELEY_ICON_E = preload("uid://bra4w0vi5blmm")
const GOLLUX_ICON = preload("uid://cibat57xa7skf")
const GOLEM_ICON = preload("uid://dctw5i7e8cwyv")
const PLATFORM = preload("uid://bbp0plbv7agbs")

const BOOK_scene = preload("uid://qrj8wlmcg1as")

var tracking = {}

func _ready() -> void:
	for book in coins.get_children(): # Coins
		
		var book_node = BOOK_scene.instantiate()
		book_node.scale = Vector2(0.338, 0.338)
		main.get_parent().add_child(book_node)
		main.get_parent().move_child(book_node, 2)
		book_node.global_position = book.global_position

		tracking[book] = book_node
		
	for skeley in skeleton_e.get_children(): #Skeleton Easy
		var skeleyH_node = Sprite2D.new()
		skeleyH_node.texture = SKELEY_ICON_E
		skeleyH_node.scale = Vector2(0.02, 0.02)
		main.get_parent().add_child(skeleyH_node)
		main.get_parent().move_child(skeleyH_node, 2)
		skeleyH_node.global_position = skeley.global_position

		tracking[skeley] = skeleyH_node

	for skeley in skeleton_d.get_children(): # Skeleton hard
		var skeleyH_node = Sprite2D.new()
		skeleyH_node.texture = SKELEY_ICON_H
		skeleyH_node.scale = Vector2(0.02, 0.02)
		main.get_parent().add_child(skeleyH_node)
		main.get_parent().move_child(skeleyH_node, 2)
		skeleyH_node.global_position = skeley.global_position

		tracking[skeley] = skeleyH_node
		
	for skeley in gollux.get_children(): #gollux
		var skeleyH_node = Sprite2D.new()
		skeleyH_node.texture = GOLLUX_ICON
		skeleyH_node.scale = Vector2(0.04, 0.04)
		main.get_parent().add_child(skeleyH_node)
		main.get_parent().move_child(skeleyH_node, 2)
		skeleyH_node.global_position = skeley.global_position

		tracking[skeley] = skeleyH_node

	for skeley in golem.get_children(): #golem
		var skeleyH_node = Sprite2D.new()
		skeleyH_node.texture = GOLEM_ICON
		skeleyH_node.scale = Vector2(0.04, 0.04)
		main.get_parent().add_child(skeleyH_node)
		main.get_parent().move_child(skeleyH_node, 2)
		skeleyH_node.global_position = skeley.global_position

		tracking[skeley] = skeleyH_node
	
	for platform in platforms.get_children(): # platforms
		
		var platform_node = PLATFORM.instantiate()
		platform_node.scale = Vector2(0.063, 0.09)
		main.get_parent().add_child(platform_node)
		main.get_parent().move_child(platform_node, 2)
		platform_node.global_position = platform.global_position
		
		tracking[platform] = platform_node

func _process(_delta: float) -> void:
	var to_remove = []
	for reference in tracking:
		if !is_instance_valid(reference):
			tracking[reference].queue_free()
			to_remove.append(reference)
		else:
			tracking[reference].global_position = reference.global_position
	for thing in to_remove:
		tracking.erase(thing)
	
	
	camera_2d.position = GameManager.player_pos
	knight_icon.position = GameManager.player_pos

func _on_hide_button_pressed() -> void:
	main_panel.visible = !main_panel.visible
	secondary_panel.visible = main_panel.visible
	if hidden:
		hidden = false
		hide_button.text = "Hide"
	else:
		hidden = true
		hide_button.text = "Show"
		
