[gd_scene load_steps=2 format=3 uid="uid://dujp441kf3a1j"]

[ext_resource type="Script" path="res://scripts/game_over.gd" id="1_8a8gq"]

[node name="GameOverScene" type="Control"]
layout_mode = 3
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
script = ExtResource("1_8a8gq")

[node name="Background" type="ColorRect"]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
color = Color(0.901961, 0.901961, 0.901961, 1)

[node name="VBoxContainer" type="VBoxContainer"]
layout_mode = 1
anchors_preset = 8
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
offset_left = -200.0
offset_top = -150.0
offset_right = 200.0
offset_bottom = 150.0
grow_horizontal = 2
grow_vertical = 2
theme_override_constants/separation = 20
alignment = 1

[node name="TitleLabel" type="Label"]
layout_mode = 2
theme_override_font_sizes/font_size = 36
text = "Game Over"
horizontal_alignment = 1

[node name="ResultLabel" type="Label"]
layout_mode = 2
theme_override_font_sizes/font_size = 28
text = "Player X Wins!"
horizontal_alignment = 1

[node name="ScoreLabel" type="Label"]
layout_mode = 2
theme_override_font_sizes/font_size = 24
text = "Final Score - X: 0 | O: 0"
horizontal_alignment = 1

[node name="HSeparator" type="HSeparator"]
layout_mode = 2

[node name="PlayAgainButton" type="Button"]
custom_minimum_size = Vector2(0, 60)
layout_mode = 2
theme_override_font_sizes/font_size = 20
text = "Play Again"

[node name="MainMenuButton" type="Button"]
custom_minimum_size = Vector2(0, 60)
layout_mode = 2
theme_override_font_sizes/font_size = 20
text = "Main Menu"

[connection signal="pressed" from="VBoxContainer/PlayAgainButton" to="." method="_on_play_again_button_pressed"]
[connection signal="pressed" from="VBoxContainer/MainMenuButton" to="." method="_on_main_menu_button_pressed"]
