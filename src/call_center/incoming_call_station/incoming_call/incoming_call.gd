extends Control

export(int) var id = 0

# Signals

signal line_input_pressing
signal line_input_released

signal call_answered
signal call_rejected


# States
const FREE = 0
const CALL_INCOMING = 1
const CALL_ANSWERED = 2
const CALL_REJECTED = 3
const CALL_CONNECTED = 4

var state = CALL_INCOMING
export(int) var calling_number = null

# Nodes
onready var leds = {
	"white": $VBoxContainer/CallerNumberAndLed/NotificationLED/WhiteLED,
	"blue": $VBoxContainer/CallerNumberAndLed/NotificationLED/BlueLED,
	"red": $VBoxContainer/CallerNumberAndLed/NotificationLED/RedLED,
	"green": $VBoxContainer/CallerNumberAndLed/NotificationLED/GreenLED,
	"orange": $VBoxContainer/CallerNumberAndLed/NotificationLED/OrangeLED
}
onready var reject_call = $VBoxContainer/CallActionAndLineInput/CenterContainer/RejectCall
onready var answer_call = $VBoxContainer/CallActionAndLineInput/CenterContainer2/AnswerCall
onready var line_input = $VBoxContainer/CallActionAndLineInput/LineInput
onready var digits = $VBoxContainer/CallerNumberAndLed/CallerNumber.get_children()

func _ready():
	setup_ui()

func setup_digit():
	if not calling_number:
		return
	
	var digits_extracted = [
		(calling_number / 1000) % 10,
		(calling_number / 100) % 10,
		(calling_number / 10) % 10,
		(calling_number / 1) % 10
	]
	
	for i in range(digits.size()):
		digits[i].set_text(str(digits_extracted[i]))

func setup_ui():
	setup_digit()
	
	match state:
		FREE:
			show_led("white")
			disable_and_lower_opacity(reject_call)
			disable_and_lower_opacity(answer_call)
			disable(line_input)
		CALL_INCOMING:
			show_led("red")
			disable_and_lower_opacity(reject_call)
			enable(answer_call)
			disable(line_input)
		CALL_ANSWERED:
			show_led("green")
			disable_and_lower_opacity(answer_call)
			enable(reject_call)
			enable(line_input)
		CALL_REJECTED:
			show_led("orange")
			disable_and_lower_opacity(reject_call)
			disable_and_lower_opacity(answer_call)
			disable(line_input)
		CALL_CONNECTED:
			show_led("blue")
			disable_and_lower_opacity(reject_call)
			disable_and_lower_opacity(answer_call)
			disable(line_input)

func disable_and_lower_opacity(obj):
	disable(obj)
	obj.modulate.a = 0.5

func disable(obj):
	obj.mouse_default_cursor_shape = CURSOR_ARROW
	obj.disabled = true

func enable(obj):
	obj.modulate.a = 1
	obj.disabled = false
	obj.mouse_default_cursor_shape = CURSOR_POINTING_HAND

func show_led(led_name):
	for led in leds:
		if led == led_name:
			leds[led].visible = true
		else:
			leds[led].visible = false

func _on_LineInput_button_up():
	emit_signal("line_input_released", id)

func _on_LineInput_button_down():
	emit_signal("line_input_pressing", id)

func _on_RejectCall_pressed():
	pass # replace with function body
