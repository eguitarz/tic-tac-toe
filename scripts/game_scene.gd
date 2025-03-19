extends Control

# References to UI elements
@onready var turn_label = $UI/TurnLabel
@onready var score_label = $UI/ScoreLabel
@onready var grid_container = $GridContainer
@onready var game_over_popup = $GameOverPopup

# Reference to the game manager
var game_manager = null

# Preload the cell scene
var cell_scene = preload("res://scenes/cell.tscn")

# Cell instances
var cells = []

func _ready():
	# Create game manager and connect signals
	game_manager = Node.new()
	game_manager.set_script(load("res://scripts/game_manager.gd"))
	add_child(game_manager)
	
	game_manager.cell_pressed.connect(_on_cell_pressed)
	game_manager.turn_changed.connect(_update_turn_label)
	game_manager.game_over.connect(_on_game_over)
	
	# Setup the grid
	setup_grid()
	
	# Start new game
	new_game()

# Setup the 3x3 grid of cells
func setup_grid():
	# Clear any existing cells
	for child in grid_container.get_children():
		grid_container.remove_child(child)
		child.queue_free()
	
	cells.clear()
	
	# Create 3x3 grid of cells
	for i in range(3):
		var row = []
		for j in range(3):
			var cell_instance = cell_scene.instantiate()
			grid_container.add_child(cell_instance)
			
			# Initialize the cell and connect signals
			cell_instance.init(i, j)
			cell_instance.cell_clicked.connect(_on_cell_clicked)
			
			row.append(cell_instance)
		cells.append(row)

# Start a new game
func new_game():
	game_manager.reset_game()
	
	# Reset all cells
	for i in range(3):
		for j in range(3):
			cells[i][j].reset()
	
	# Update UI
	_update_score_label()
	_update_turn_label(game_manager.get_player())
	
	# Hide game over popup if it's visible
	game_over_popup.visible = false

# Handle cell click from UI
func _on_cell_clicked(row, col):
	game_manager.make_move(row, col)

# Update cell visual when game manager signals a cell was pressed
func _on_cell_pressed(row, col):
	cells[row][col].set_value(game_manager.get_player())

# Update the turn indicator
func _update_turn_label(player):
	if turn_label:
		turn_label.text = "Current Turn: " + player

# Update the score display
func _update_score_label():
	var scores = game_manager.get_scores()
	if score_label:
		score_label.text = "Score - X: " + str(scores["X"]) + " | O: " + str(scores["O"])

# Handle game over state
func _on_game_over(winner):
	_update_score_label()
	
	# Show game over popup
	game_over_popup.visible = true
	
	# Update game over message
	var game_over_label = game_over_popup.get_node("VBoxContainer/GameOverLabel")
	if game_over_label:
		if winner == null:
			game_over_label.text = "It's a Draw!"
		else:
			game_over_label.text = "Player " + winner + " Wins!"

# Button handlers
func _on_restart_button_pressed():
	new_game()

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_play_again_button_pressed():
	new_game()

func _on_back_to_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
