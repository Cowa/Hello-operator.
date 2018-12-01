extends Control

export(int) var id = 0

signal line_input_pressing
signal line_input_released

func _ready():
	pass

func _on_LineInput_button_up():
	emit_signal("line_input_released", id)

func _on_LineInput_button_down():
	emit_signal("line_input_pressing", id)
