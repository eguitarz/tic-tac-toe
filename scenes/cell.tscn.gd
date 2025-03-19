[gd_scene load_steps=2 format=3 uid="uid://cq8p2qlrb1nyd"]

[ext_resource type="Script" path="res://scripts/cell.gd" id="1_fkf2f"]

[node name="Cell" type="Control"]
custom_minimum_size = Vector2(100, 100)
layout_mode = 3
anchors_preset = 0
script = ExtResource("1_fkf2f")

[node name="ColorRect" type="ColorRect"]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
color = Color(0.878431, 0.878431, 0.878431, 1)

[node name="Button" type="Button"]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
flat = true

[node name="XMarker" type="Label"]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
theme_override_colors/font_color = Color(1, 0, 0, 1)
theme_override_font_sizes/font_size = 64
text = "X"
horizontal_alignment = 1
vertical_alignment = 1

[node name="OMarker" type="Label"]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
theme_override_colors/font_color = Color(0, 0, 1, 1)
theme_override_font_sizes/font_size = 64
text = "O"
horizontal_alignment = 1
vertical_alignment = 1

[node name="HoverIndicator" type="ColorRect"]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
mouse_filter = 2
color = Color(0.392157, 0.392157, 0.392157, 0.2)
