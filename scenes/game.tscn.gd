[gd_scene load_steps=2 format=3 uid="uid://c7dki7d4c0nwi"]

[ext_resource type="Script" path="res://scripts/game_scene.gd" id="1_hy6y4"]

[node name="GameScene" type="Control"]
layout_mode = 3
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
script = ExtResource("1_hy6y4")

[node name="Background" type="ColorRect"]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
color = Color(0.901961, 0.901961, 0.901961, 1)

[node name="UI" type="VBoxContainer"]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
theme_override_constants/separation = 20

[node name="Title" type="Label"]
layout_mode = 2
theme_override_font_sizes/font_size = 36
text = "Tic Tac Toe"
horizontal_alignment = 1

[node name="TurnLabel" type="Label"]
layout_mode = 2
theme_override_font_sizes/font_size = 24
text = "Current Turn: X"
horizontal_alignment = 1

[node name="ScoreLabel" type="Label"]
layout_mode = 2
theme_override_font_sizes/font_size = 20
text = "Score - X: 0 | O: 0"
horizontal_alignment = 1

[node name="CenterContainer" type="CenterContainer"]
layout_mode = 2
size_flags_vertical = 3

[node name="GridContainer" type="GridContainer"]
layout_mode = 2
theme_override_constants/h_separation = 10
theme_override_constants/v_separation = 10
columns = 3

[node name="ButtonContainer" type="HBoxContainer"]
layout_mode = 2
alignment = 1

[node name="RestartButton" type="Button"]
custom_minimum_size = Vector2(120, 50)
layout_mode = 2
text = "Restart"

[node name="MainMenuButton" type="Button"]
custom_minimum_size = Vector2(120, 50)
layout_mode = 2
text = "Main Menu"

[node name="GameOverPopup" type="Panel"]
visible = false
layout_mode = 1
anchors_preset = 8
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
offset_left = -150.0
offset_top = -100.0
offset_right = 150.0
offset_bottom = 100.0
grow_horizontal = 2
grow_vertical = 2

[node name="VBoxContainer" type="VBoxContainer"]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
alignment = 1

[node name="GameOverLabel" type="Label"]
layout_mode = 2
theme_override_font_sizes/font_size = 24
text = "Player X Wins!"
horizontal_alignment = 1

[node name="HSeparator" type="HSeparator"]
layout_mode = 2

[node name="PlayAgainButton" type="Button"]
custom_minimum_size = Vector2(0, 40)
layout_mode = 2
size_flags_horizontal = 3
size_flags_vertical = 4
text = "Play Again"

[node name="BackToMenuButton" type="Button"]
custom_minimum_size = Vector2(0, 40)
layout_mode = 2
size_flags_horizontal = 3
size_flags_vertical = 4
text = "Back to Menu"

[connection signal="pressed" from="UI/ButtonContainer/RestartButton" to="." method="_on_restart_button_pressed"]
[connection signal="pressed" from="UI/ButtonContainer/MainMenuButton" to="." method="_on_main_menu_button_pressed"]
[connection signal="pressed" from="GameOverPopup/VBoxContainer/PlayAgainButton" to="." method="_on_play_again_button_pressed"]
[connection signal="pressed" from="GameOverPopup/VBoxContainer/BackToMenuButton" to="." method="_on_back_to_menu_button_pressed"]
