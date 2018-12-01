extends Control

export(int) var id = 0

# Signals

signal line_input_pressing
signal line_input_released

signal call_answered
signal call_rejected
signal call_connected

###### States
const FREE = 0
const CALL_INCOMING = 1
const CALL_ANSWERED = 2
const CALL_REJECTED = 3
const CALL_CONNECTED = 4

var state = FREE
export(String) var calling_number = null
export(int) var dialog_speed = 1

var time_waiting_before_answering = 0
var time_waiting_before_connecting_or_rejecting = 0

###### Nodes
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
	change_state(state)
	setup_ui()

func setup_digit():
	if not calling_number:
		for i in range(digits.size()):
			digits[i].modulate.a = 0
		return
	
	for i in range(digits.size()):
		digits[i].modulate.a = 1
		digits[i].set_text(str(calling_number[i]))

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
			$Dialog.visible = true
			$Dialog/DialogAnimation.play("speaking")
		CALL_REJECTED:
			show_led("orange")
			disable_and_lower_opacity(reject_call)
			disable_and_lower_opacity(answer_call)
			disable(line_input)
			$Dialog/DialogAnimation.play("closing")
		CALL_CONNECTED:
			show_led("blue")
			disable_and_lower_opacity(reject_call)
			disable_and_lower_opacity(answer_call)
			disable(line_input, true)
			$Dialog/DialogAnimation.play("closing")

func disable_and_lower_opacity(obj):
	disable(obj)
	obj.modulate.a = 0.5

func disable(obj, fire_released = false):
	obj.mouse_default_cursor_shape = CURSOR_ARROW
	obj.disabled = true
	
	if fire_released:
		_on_LineInput_button_up()

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

func adjust_animation_speed():
	if time_waiting_before_answering < 5:
		return 2
	elif time_waiting_before_answering < 10:
		return 4
	elif time_waiting_before_answering < 15:
		return 8
	else:
		return 10

func change_state(new_state):
	state = new_state
	
	$AnimationPlayer.playback_speed = adjust_animation_speed()
	$AnimationPlayer.play("setup")
	
	if state in [FREE, CALL_REJECTED, CALL_CONNECTED]:
		$TimePassing.stop()
	
	if state == CALL_INCOMING:
		$AnimationPlayer.play("incoming_call")
		$TimePassing.start()
	
	if state == FREE:
		# Reset time counter
		time_waiting_before_answering = 0
		time_waiting_before_connecting_or_rejecting = 0
		calling_number = null
	
	setup_ui()

func ringing(caller_number):
	calling_number = caller_number
	$TimePassing.start()
	change_state(CALL_INCOMING)

func is_free():
	return state == FREE

func is_busy():
	return not is_free()

func _on_LineInput_button_up():
	if Input.is_action_just_released("left_click"):
		emit_signal("line_input_released", id)

func _on_LineInput_button_down():
	if Input.is_action_just_pressed("left_click"):
		emit_signal("line_input_pressing", id)

##### END CALL

func _on_RejectCall_pressed():
	$RejectCallTimer.start()
	change_state(CALL_REJECTED)
	yield($RejectCallTimer, "timeout")
	emit_signal("call_rejected", id, calling_number)
	change_state(FREE)

func call_connected(with_number):
	change_state(CALL_CONNECTED)
	$ConnectCallTimer.start()
	yield($ConnectCallTimer, "timeout")
	emit_signal("call_connected", id, calling_number)
	change_state(FREE)
#####

func _on_AnswerCall_pressed():
	emit_signal("call_answered", id)
	change_state(CALL_ANSWERED)

func _on_TimePassing_timeout():
	if state == CALL_INCOMING:
		time_waiting_before_answering += $TimePassing.wait_time
		$AnimationPlayer.playback_speed = adjust_animation_speed()
	elif state == CALL_ANSWERED:
		time_waiting_before_connecting_or_rejecting += $TimePassing.wait_time
