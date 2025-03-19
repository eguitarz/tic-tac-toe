extends Control

# Button handlers
func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_options_button_pressed():
	# For now, just a placeholder
	print("Options button pressed")

func _on_quit_button_pressed():
	get_tree().quit()
