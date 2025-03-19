; Engine configuration file.
; It's best edited using the editor UI and not directly,
; since the parameters that go here are not all obvious.
;
; Format:
;   [section] ; section goes between []
;   param=value ; assign values to parameters

config_version=5

[application]

config/name="Tic-Tac-Toe"
run/main_scene="res://main.tscn"
config/features=PackedStringArray("4.4", "Mobile")

[display]

window/size/viewport_width=600
window/size/viewport_height=800
window/stretch/mode="canvas_items"

[rendering]

renderer/rendering_method="mobile"
