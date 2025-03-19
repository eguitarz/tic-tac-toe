extends Control

signal cell_clicked(row, col)

var row: int
var col: int
var cell_value: String = ""

# Reference to the markers (X and O)
@onready var x_marker = $XMarker
@onready var o_marker = $OMarker
@onready var hover_indicator = $HoverIndicator
@onready var button = $Button

func _ready():
	button.pressed.connect(_on_button_pressed)
	button.mouse_entered.connect(_on_mouse_entered)
	button.mouse_exited.connect(_on_mouse_exited)
	
	# Initially hide markers
	if x_marker:
		x_marker.visible = false
	if o_marker:
		o_marker.visible = false
	if hover_indicator:
		hover_indicator.visible = false

# Set the position in the grid
func init(r: int, c: int):
	row = r
	col = c

# Set the cell's value (X, O, or empty)
func set_value(value: String):
	cell_value = value
	
	# Update visuals
	if value == "X":
		if x_marker:
			x_marker.visible = true
		if o_marker:
			o_marker.visible = false
	elif value == "O":
		if x_marker:
			x_marker.visible = false
		if o_marker:
			o_marker.visible = true
	else:
		# Empty cell
		if x_marker:
			x_marker.visible = false
		if o_marker:
			o_marker.visible = false
	
	# Disable button if cell is filled
	if value != "":
		button.disabled = true
	else:
		button.disabled = false

# Handle click event
func _on_button_pressed():
	if cell_value == "":
		emit_signal("cell_clicked", row, col)

# Show hover indicator
func _on_mouse_entered():
	if cell_value == "" and hover_indicator:
		hover_indicator.visible = true

# Hide hover indicator
func _on_mouse_exited():
	if hover_indicator:
		hover_indicator.visible = false

# Reset the cell
func reset():
	cell_value = ""
	if x_marker:
		x_marker.visible = false
	if o_marker:
		o_marker.visible = false
	button.disabled = false
