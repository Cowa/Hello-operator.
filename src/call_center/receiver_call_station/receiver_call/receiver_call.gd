extends Control

export(int) var id = 0

func _ready():
	pass

func line_input_position():
	return $LineInput.get_global_rect().position + ($LineInput.get_global_rect().size / Vector2(2, 2))