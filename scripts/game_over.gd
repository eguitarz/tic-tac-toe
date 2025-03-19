extends Control

# References to UI elements
@onready var result_label = $VBoxContainer/ResultLabel
@onready var score_label = $VBoxContainer/ScoreLabel

# Set the result message and score
func set_result(winner, scores):
	if winner == null:
		result_label.text = "It's a Draw!"
	else:
		result_label.text = "Player " + winner + " Wins!"
	
	score_label.text = "Final Score - X: " + str(scores["X"]) + " | O: " + str(scores["O"])

# Button handlers
func _on_play_again_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
