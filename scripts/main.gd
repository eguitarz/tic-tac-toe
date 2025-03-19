extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	# Create the game scene
	var game_scene = load("res://scripts/tictactoe_game.gd").new()
	add_child(game_scene)
