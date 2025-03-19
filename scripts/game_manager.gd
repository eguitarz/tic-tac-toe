extends Node

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

# Game board - 3x3 grid
# null = empty, "X" = player X, "O" = player O
var board = [
	[null, null, null],
	[null, null, null],
	[null, null, null]
]

signal cell_pressed(row, col)
signal game_over(winner)
signal turn_changed(player)

func _ready():
	reset_game()

# Initialize a new game
func reset_game():
	# Clear the board
	for i in range(3):
		for j in range(3):
			board[i][j] = null
	
	# Reset to initial state
	current_state = GameState.PLAYING
	current_player = PLAYER_X
	
	# Signal that it's the first player's turn
	emit_signal("turn_changed", current_player)

# Handle a player's move
func make_move(row, col):
	# Ignore if game is already over or cell is already filled
	if current_state != GameState.PLAYING or board[row][col] != null:
		return false
	
	# Update the board with current player's symbol
	board[row][col] = current_player
	
	# Tell the UI that a cell was updated
	emit_signal("cell_pressed", row, col)
	
	# Check for win or draw
	check_game_state()
	
	# If game is still going, switch to next player
	if current_state == GameState.PLAYING:
		current_player = PLAYER_O if current_player == PLAYER_X else PLAYER_X
		emit_signal("turn_changed", current_player)
	
	return true

# Check if the current player has won or if it's a draw
func check_game_state():
	# Check rows
	for i in range(3):
		if board[i][0] != null and board[i][0] == board[i][1] and board[i][1] == board[i][2]:
			current_state = GameState.WIN
			update_score()
			emit_signal("game_over", current_player)
			return
	
	# Check columns
	for i in range(3):
		if board[0][i] != null and board[0][i] == board[1][i] and board[1][i] == board[2][i]:
			current_state = GameState.WIN
			update_score()
			emit_signal("game_over", current_player)
			return
	
	# Check diagonals
	if board[0][0] != null and board[0][0] == board[1][1] and board[1][1] == board[2][2]:
		current_state = GameState.WIN
		update_score()
		emit_signal("game_over", current_player)
		return
	
	if board[0][2] != null and board[0][2] == board[1][1] and board[1][1] == board[2][0]:
		current_state = GameState.WIN
		update_score()
		emit_signal("game_over", current_player)
		return
	
	# Check for draw (all cells filled)
	var is_board_full = true
	for i in range(3):
		for j in range(3):
			if board[i][j] == null:
				is_board_full = false
				break
		if not is_board_full:
			break
	
	if is_board_full:
		current_state = GameState.DRAW
		emit_signal("game_over", null)  # null indicates a draw

# Update the score for the winner
func update_score():
	if current_player == PLAYER_X:
		score_x += 1
	else:
		score_o += 1

# Get the current game state
func get_state():
	return current_state

# Get the current player
func get_player():
	return current_player

# Get scores
func get_scores():
	return {"X": score_x, "O": score_o}
