extends Control

export(int) var id = 0

signal line_input_pressed
signal line_input_released

func _ready():
	pass

func _on_LineInput_button_up():
	emit_signal("line_input_released", id)
	print("released line: " + str(id))

func _on_LineInput_button_down():
	emit_signal("line_input_pressed", id)
	print("pressing line: " + str(id))
