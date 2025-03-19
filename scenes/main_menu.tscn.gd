[gd_scene load_steps=2 format=3 uid="uid://bx3u0ylpkjfxx"]

[ext_resource type="Script" path="res://scripts/main_menu.gd" id="1_5qglg"]

[node name="MainMenu" type="Control"]
layout_mode = 3
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
script = ExtResource("1_5qglg")

[node name="CenterContainer" type="CenterContainer"]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2

[node name="VBoxContainer" type="VBoxContainer"]
layout_mode = 2
theme_override_constants/separation = 20

[node name="TitleLabel" type="Label"]
layout_mode = 2
theme_override_font_sizes/font_size = 48
text = "Tic Tac Toe"
horizontal_alignment = 1

[node name="HSeparator" type="HSeparator"]
custom_minimum_size = Vector2(200, 0)
layout_mode = 2

[node name="PlayButton" type="Button"]
custom_minimum_size = Vector2(200, 60)
layout_mode = 2
theme_override_font_sizes/font_size = 24
text = "Play"

[node name="OptionsButton" type="Button"]
custom_minimum_size = Vector2(200, 60)
layout_mode = 2
theme_override_font_sizes/font_size = 24
text = "Options"

[node name="QuitButton" type="Button"]
custom_minimum_size = Vector2(200, 60)
layout_mode = 2
theme_override_font_sizes/font_size = 24
text = "Quit"

[connection signal="pressed" from="CenterContainer/VBoxContainer/PlayButton" to="." method="_on_play_button_pressed"]
[connection signal="pressed" from="CenterContainer/VBoxContainer/OptionsButton" to="." method="_on_options_button_pressed"]
[connection signal="pressed" from="CenterContainer/VBoxContainer/QuitButton" to="." method="_on_quit_button_pressed"]
