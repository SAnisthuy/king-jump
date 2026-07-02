extends Control

@onready var attack_cooldown: ProgressBar = $"Attack Cooldown"

func _process(_delta: float) -> void:
	if GameManager.player_attack_cooldown != null:
		attack_cooldown.value = GameManager.player_attack_cooldown
	else: attack_cooldown.value = 0
