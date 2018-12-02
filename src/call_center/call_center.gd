extends Control

onready var phone_numbers = $PhoneNumberState

onready var incoming_calls = [
	$IncomingCallStation/VBoxContainer/CenterContainer1/IncomingCall1,
	$IncomingCallStation/VBoxContainer/CenterContainer2/IncomingCall2,
	$IncomingCallStation/VBoxContainer/CenterContainer3/IncomingCall3
]

onready var receiver_calls = [
	$ReceiverCallStation/GridContainer/CenterContainer1/ReceiverCall1,
	$ReceiverCallStation/GridContainer/CenterContainer2/ReceiverCall2,
	$ReceiverCallStation/GridContainer/CenterContainer3/ReceiverCall3,
	$ReceiverCallStation/GridContainer/CenterContainer4/ReceiverCall4,
	$ReceiverCallStation/GridContainer/CenterContainer5/ReceiverCall5,
	$ReceiverCallStation/GridContainer/CenterContainer6/ReceiverCall6,
	$ReceiverCallStation/GridContainer/CenterContainer7/ReceiverCall7,
	$ReceiverCallStation/GridContainer/CenterContainer8/ReceiverCall8
]

onready var link_cables = [
	$LinkCables/Cable1,
	$LinkCables/Cable2,
	$LinkCables/Cable3
]

#### States

# Dragging cables
var connecting_cables = [false, false, false]
# Cables connected to...
var connected_cables = [null, null, null]
# At start, only on simltaneous call
var simultaneous_call = 1
# Number of calls managed
var managed_call = 0
var suspicious = 0

export(int) var time_remaining = 300

#####

func _ready():
	for incoming_call in incoming_calls:
		incoming_call.connect("line_input_released", self, "_on_line_input_released", [], CONNECT_DEFERRED)
		incoming_call.connect("line_input_pressing", self, "_on_line_input_pressing", [], CONNECT_DEFERRED)
		incoming_call.connect("call_rejected", self, "_on_call_rejected", [], CONNECT_DEFERRED)
		incoming_call.connect("call_connected", self, "_on_call_connected", [], CONNECT_DEFERRED)
		incoming_call.connect("call_timeout", self, "_on_call_timeout", [], CONNECT_DEFERRED)
	
	$Desk.fill_lists(phone_numbers.propaganda_list, phone_numbers.resistance_list)
	$ReceiverCallStation.fill_receiver_numbers(phone_numbers.receiver_list)
	$Wall/SuspiciousMeter.update_meter(suspicious)
	$Wall/Clock.update_time(time_remaining)

func _input(event):
	if event is InputEventMouseMotion:
		for i in range(link_cables.size()):
			if connecting_cables[i]:
				update_link_cable_curves(event.position, link_cables[i])
	elif event is InputEventMouseButton and not event.is_pressed() and event.button_index == BUTTON_LEFT:
		for i in range(link_cables.size()):
			var receiver = get_connecting_receiver(event.position)
			if connecting_cables[i] and receiver:
				connected_cables[i] = receiver
				update_link_cable_curves(receiver.line_input_position(), link_cables[i])
				incoming_calls[i].call_connected(receiver.number())

func _on_line_input_released(incoming_call_id):
	var local_id = incoming_call_id - 1
	var link_cable = link_cables[local_id]
	connecting_cables[local_id] = false
	if connected_cables[local_id]:
		return
	
	link_cable.clear()

func _on_line_input_pressing(incoming_call_id):
	var local_id = incoming_call_id - 1
	connecting_cables[local_id] = true
	connected_cables[local_id] = null
	
	var incoming_call = incoming_calls[local_id]
	var line_input = incoming_call.get_node("VBoxContainer/CallActionAndLineInput/LineInput")
	
	var link_cable = link_cables[local_id]
	
	var line_input_rect = line_input.get_global_rect()
	var line_input_center = line_input_rect.position + (line_input_rect.size / Vector2(2, 2))
	
	link_cable.curve.set_point_position(0, line_input_center)
	link_cable.curve.set_point_position(1, line_input_center)
	
	link_cable.update()

func _on_call_rejected(incoming_call_id, calling_number):
	var local_id = incoming_call_id - 1
	connected_cables[local_id] = null
	_on_line_input_released(incoming_call_id)
	
	if phone_numbers.is_propaganda(calling_number):
		increase_suspicious(25)
		state.inc_rejected_propaganda()
	elif phone_numbers.is_resistance(calling_number):
		state.inc_rejected_resistance()
		decrease_suspicious(25)
	# Reject neutral number is suspect
	else:
		increase_suspicious(5)
		state.inc_failed_call()
	
	managed_call += 1

func _on_call_connected(incoming_call_id, calling_number, correct_receiver):
	var local_id = incoming_call_id - 1
	connected_cables[local_id] = null
	_on_line_input_released(incoming_call_id)
	
	if correct_receiver:
		if phone_numbers.is_propaganda(calling_number):
			decrease_suspicious(10)
			state.inc_propaganda()
		elif phone_numbers.is_resistance(calling_number):
			state.inc_resistance()
			increase_suspicious(30)
		else:
			state.inc_call()
			decrease_suspicious(5)
		managed_call += 1
	else:
		state.inc_failed_call()
		if phone_numbers.is_propaganda(calling_number):
			increase_suspicious(10)
		elif phone_numbers.is_resistance(calling_number):
			increase_suspicious(15)
		else:
			increase_suspicious(10)

func _on_call_timeout(incoming_call_id):
	state.inc_missed_call()
	var local_id = incoming_call_id - 1
	connected_cables[local_id] = null
	increase_suspicious(10)

func update_link_cable_curves(mouse_position, link_cable):
	link_cable.curve.set_point_position(1, mouse_position)
	link_cable.update()

func get_connecting_receiver(mouse_position):
	for receiver in receiver_calls:
		if receiver.get_global_rect().has_point(mouse_position):
			return receiver
	return null

func adjust_difficulty():
	var new_simultaneous = 1
	if managed_call < 4:
		new_simultaneous = 1
	elif managed_call < 12:
		new_simultaneous = 2
	else:
		new_simultaneous = 3
	simultaneous_call = new_simultaneous

func increase_suspicious(added):
	suspicious += added
	
	if suspicious >= 100:
		suspicious = 100
		# Game over
		$TimeClicking.stop()
		$AnimationPlayer.play("end")
		yield($AnimationPlayer, "animation_finished")
		get_tree().change_scene("res://src/day_result/GameOver.tscn")
	
	$Wall/SuspiciousMeter.update_meter(suspicious)

func decrease_suspicious(added):
	suspicious -= added
	
	if suspicious < 0:
		suspicious = 0
	
	$Wall/SuspiciousMeter.update_meter(suspicious)

func generate_call():
	# caller number, receiver number, dialog, (speed dialog?)
	var call = {
		caller_type = null,
		caller_number = null,
		receiver_number = utils.choose(phone_numbers.receiver_list),
		dialogs = []
	}
	
	if utils.odds(2):
		if utils.odds(2):
			call.caller_number = utils.choose(phone_numbers.resistance_list)
			call.caller_type = "resistance"
		else:
			call.caller_number = utils.choose(phone_numbers.propaganda_list)
			call.caller_type = "propaganda"
	else:
		call.caller_number = phone_numbers.generate_new_number()
		call.caller_type = "neutral"
	
	call.dialogs = generate_dialogs(call)
	return call

func generate_dialogs(call):
	var dialogs = []
	match call.caller_type:
		"resistance":
			dialogs = utils.choose($DialogData.resistance_dialogs)
		"propaganda":
			dialogs = utils.choose($DialogData.propaganda_dialogs)
		"neutral":
			dialogs = utils.choose($DialogData.neutral_dialogs)
	
	var dialog_parsed = []
	# replace XXXX with receiver number
	for d in dialogs:
		dialog_parsed.append(d.replace("XXXX", call.receiver_number))
	
	return dialog_parsed

func maybe_send_call():
	adjust_difficulty()
	
	var free_calls = []
	for call in incoming_calls:
		if call.is_free():
			free_calls.append(call)
	
	var ongoing_call_number = incoming_calls.size() - free_calls.size()
	
	if ongoing_call_number < simultaneous_call:
		var call_data = generate_call()
		var choosen_call = utils.choose(free_calls)
		var generated_call = generate_call()
		choosen_call.ringing(generated_call)

func _on_NewCallTimer_timeout():
	maybe_send_call()

func _on_TimeClicking_timeout():
	time_remaining -= 1
	
	if time_remaining < 0:
		$TimeClicking.stop()
		$AnimationPlayer.play("end")
		yield($AnimationPlayer, "animation_finished")
		get_tree().change_scene("res://src/day_result/DayResult.tscn")
	
	$Wall/Clock.update_time(time_remaining)
