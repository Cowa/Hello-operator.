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

var connecting_cables = [
	false,
	false,
	false
]

var connected_cables = [
	null,
	null,
	null
]

func _ready():
	for incoming_call in incoming_calls:
		incoming_call.connect("line_input_released", self, "_on_line_input_released", [], CONNECT_DEFERRED)
		incoming_call.connect("line_input_pressing", self, "_on_line_input_pressing", [], CONNECT_DEFERRED)
	$Desk.fill_lists(phone_numbers.propaganda_list, phone_numbers.resistance_list)
	$ReceiverCallStation.fill_receiver_numbers(phone_numbers.receiver_list)
	
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
				incoming_calls[i].call_connected()

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

func update_link_cable_curves(mouse_position, link_cable):
	link_cable.curve.set_point_position(1, mouse_position)
	link_cable.update()

func get_connecting_receiver(mouse_position):
	for receiver in receiver_calls:
		if receiver.get_global_rect().has_point(mouse_position):
			return receiver
	return null