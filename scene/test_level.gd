extends Node3D

@onready var player: CharacterBody3D = $player
@onready var hud: CanvasLayer = $HUD
@onready var game_over: CanvasLayer = $GameOver


func _ready() -> void:
	player.health_changed.connect(hud.set_health)
	player.died.connect(game_over.show_game_over)
