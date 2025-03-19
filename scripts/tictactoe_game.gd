extends Node

# This script sets up the entire Tic-Tac-Toe game programmatically
# It acts as the main scene controller

# Game state
enum GameState {PLAYING, WIN, DRAW}
var current_state = GameState.PLAYING

# Player symbols
const PLAYER_X = "X"
const PLAYER_O = "O"
var current_player = PLAYER_X

# Score tracking
var score_x = 0
var score_o = 0

# Board size
const BOARD_SIZE = 3

# Game board - 3x3 grid
# null = empty, "X" = player X, "O" = player O
var board = []

# UI elements
var main_container: Control
var grid_container: GridContainer
var turn_label: Label
var score_label: Label
var game_over_panel: Panel
var result_label: Label  # Reference to store the result label directly
var cells = []

func _ready():
	# Initialize the board
	for i in range(BOARD_SIZE):
		var row = []
		for j in range(BOARD_SIZE):
			row.append(null)
		board.append(row)
	
	# Create the UI
	setup_ui()
	
	# Start the game
	reset_game()

func setup_ui():
	# Main container
	main_container = Control.new()
	main_container.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(main_container)
	
	# Background
	var background = ColorRect.new()
	background.set_anchors_preset(Control.PRESET_FULL_RECT)
	background.color = Color(0.9, 0.9, 0.9)
	main_container.add_child(background)
	
	# Main VBox
	var vbox = VBoxContainer.new()
	vbox.set_anchors_preset(Control.PRESET_FULL_RECT)
	vbox.add_theme_constant_override("separation", 20)
	main_container.add_child(vbox)
	
	# Title
	var title = Label.new()
	title.text = "Tic Tac Toe"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 36)
	vbox.add_child(title)
	
	# Turn label
	turn_label = Label.new()
	turn_label.text = "Current Turn: X"
	turn_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	turn_label.add_theme_font_size_override("font_size", 24)
	vbox.add_child(turn_label)
	
	# Score label
	score_label = Label.new()
	score_label.text = "Score - X: 0 | O: 0"
	score_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	score_label.add_theme_font_size_override("font_size", 20)
	vbox.add_child(score_label)
	
	# Center container for grid
	var center = CenterContainer.new()
	center.size_flags_vertical = Control.SIZE_EXPAND_FILL
	vbox.add_child(center)
	
	# Grid container
	grid_container = GridContainer.new()
	grid_container.columns = BOARD_SIZE
	grid_container.add_theme_constant_override("h_separation", 10)
	grid_container.add_theme_constant_override("v_separation", 10)
	center.add_child(grid_container)
	
	# Create cells
	cells.clear()
	for i in range(BOARD_SIZE):
		var row = []
		for j in range(BOARD_SIZE):
			var cell = create_cell(i, j)
			grid_container.add_child(cell)
			row.append(cell)
		cells.append(row)
	
	# Button container
	var button_container = HBoxContainer.new()
	button_container.alignment = BoxContainer.ALIGNMENT_CENTER
	vbox.add_child(button_container)
	
	# Restart button
	var restart_button = Button.new()
	restart_button.text = "Restart"
	restart_button.custom_minimum_size = Vector2(120, 50)
	restart_button.pressed.connect(self.reset_game)
	button_container.add_child(restart_button)
	
	# Game over panel
	game_over_panel = Panel.new()
	game_over_panel.visible = false
	game_over_panel.set_anchors_preset(Control.PRESET_CENTER)
	game_over_panel.size = Vector2(300, 200)
	game_over_panel.position = Vector2(-150, -100)
	main_container.add_child(game_over_panel)
	
	var panel_vbox = VBoxContainer.new()
	panel_vbox.set_anchors_preset(Control.PRESET_FULL_RECT)
	panel_vbox.alignment = BoxContainer.ALIGNMENT_CENTER
	game_over_panel.add_child(panel_vbox)
	
	# Create and store the result label directly
	result_label = Label.new()
	result_label.text = "Player X Wins!"
	result_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	result_label.add_theme_font_size_override("font_size", 24)
	panel_vbox.add_child(result_label)
	
	var separator = HSeparator.new()
	panel_vbox.add_child(separator)
	
	var play_again_button = Button.new()
	play_again_button.text = "Play Again"
	play_again_button.custom_minimum_size = Vector2(0, 40)
	play_again_button.pressed.connect(self.reset_game)
	panel_vbox.add_child(play_again_button)

func create_cell(row, col):
	var cell = Control.new()
	cell.custom_minimum_size = Vector2(100, 100)
	
	# Background
	var bg = ColorRect.new()
	bg.set_anchors_preset(Control.PRESET_FULL_RECT)
	bg.color = Color(0.8, 0.8, 0.8)
	cell.add_child(bg)
	
	# Button
	var button = Button.new()
	button.set_anchors_preset(Control.PRESET_FULL_RECT)
	button.flat = true
	button.pressed.connect(func(): on_cell_pressed(row, col))
	cell.add_child(button)
	
	# X marker
	var x_marker = Label.new()
	x_marker.name = "XMarker"
	x_marker.text = "X"
	x_marker.set_anchors_preset(Control.PRESET_FULL_RECT)
	x_marker.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	x_marker.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	x_marker.add_theme_font_size_override("font_size", 64)
	x_marker.add_theme_color_override("font_color", Color(1, 0, 0))
	x_marker.visible = false
	cell.add_child(x_marker)
	
	# O marker
	var o_marker = Label.new()
	o_marker.name = "OMarker"
	o_marker.text = "O"
	o_marker.set_anchors_preset(Control.PRESET_FULL_RECT)
	o_marker.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	o_marker.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	o_marker.add_theme_font_size_override("font_size", 64)
	o_marker.add_theme_color_override("font_color", Color(0, 0, 1))
	o_marker.visible = false
	cell.add_child(o_marker)
	
	# Hover effect
	var hover = ColorRect.new()
	hover.name = "HoverEffect"
	hover.set_anchors_preset(Control.PRESET_FULL_RECT)
	hover.color = Color(0.5, 0.5, 0.5, 0.2)
	hover.visible = false
	hover.mouse_filter = Control.MOUSE_FILTER_IGNORE
	cell.add_child(hover)
	
	# Mouse events for hover
	button.mouse_entered.connect(func(): hover.visible = true if board[row][col] == null else false)
	button.mouse_exited.connect(func(): hover.visible = false)
	
	return cell

func reset_game():
	# Reset board data
	for i in range(BOARD_SIZE):
		for j in range(BOARD_SIZE):
			board[i][j] = null
	
	# Reset UI
	update_cell_ui()
	
	# Reset game state
	current_state = GameState.PLAYING
	current_player = PLAYER_X
	update_turn_label()
	
	# Hide game over panel
	game_over_panel.visible = false

func update_cell_ui():
	for i in range(BOARD_SIZE):
		for j in range(BOARD_SIZE):
			var cell = cells[i][j]
			var x_marker = cell.get_node("XMarker")
			var o_marker = cell.get_node("OMarker")
			
			if board[i][j] == PLAYER_X:
				x_marker.visible = true
				o_marker.visible = false
			elif board[i][j] == PLAYER_O:
				x_marker.visible = false
				o_marker.visible = true
			else:
				x_marker.visible = false
				o_marker.visible = false

func update_turn_label():
	turn_label.text = "Current Turn: " + current_player

func update_score_label():
	score_label.text = "Score - X: " + str(score_x) + " | O: " + str(score_o)

func on_cell_pressed(row, col):
	# Ignore if game is over or cell is already filled
	if current_state != GameState.PLAYING or board[row][col] != null:
		return
	
	# Update board data
	board[row][col] = current_player
	
	# Update cell UI
	update_cell_ui()
	
	# Check for win or draw
	check_game_state()
	
	# If game is still going, switch player
	if current_state == GameState.PLAYING:
		current_player = PLAYER_O if current_player == PLAYER_X else PLAYER_X
		update_turn_label()

func check_game_state():
	# Check rows
	for i in range(BOARD_SIZE):
		if board[i][0] != null and board[i][0] == board[i][1] and board[i][1] == board[i][2]:
			current_state = GameState.WIN
			update_score()
			show_game_over()
			return
	
	# Check columns
	for i in range(BOARD_SIZE):
		if board[0][i] != null and board[0][i] == board[1][i] and board[1][i] == board[2][i]:
			current_state = GameState.WIN
			update_score()
			show_game_over()
			return
	
	# Check diagonals
	if board[0][0] != null and board[0][0] == board[1][1] and board[1][1] == board[2][2]:
		current_state = GameState.WIN
		update_score()
		show_game_over()
		return
	
	if board[0][2] != null and board[0][2] == board[1][1] and board[1][1] == board[2][0]:
		current_state = GameState.WIN
		update_score()
		show_game_over()
		return
	
	# Check for draw
	var is_board_full = true
	for i in range(BOARD_SIZE):
		for j in range(BOARD_SIZE):
			if board[i][j] == null:
				is_board_full = false
				break
		if not is_board_full:
			break
	
	if is_board_full:
		current_state = GameState.DRAW
		show_game_over()
		return

func update_score():
	if current_player == PLAYER_X:
		score_x += 1
	else:
		score_o += 1
	
	update_score_label()

func show_game_over():
	# Use the directly stored result_label reference instead of trying to find it
	if current_state == GameState.WIN:
		result_label.text = "Player " + current_player + " Wins!"
	else:  # It's a draw
		result_label.text = "It's a Draw!"
	
	game_over_panel.visible = true
