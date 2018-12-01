extends TextureRect

onready var receiver_lists = [
	$GridContainer/CenterContainer1/ReceiverCall1/ReceiverNumber/Label,
	$GridContainer/CenterContainer2/ReceiverCall2/ReceiverNumber/Label,
	$GridContainer/CenterContainer3/ReceiverCall3/ReceiverNumber/Label,
	$GridContainer/CenterContainer4/ReceiverCall4/ReceiverNumber/Label,
	$GridContainer/CenterContainer5/ReceiverCall5/ReceiverNumber/Label,
	$GridContainer/CenterContainer6/ReceiverCall6/ReceiverNumber/Label,
	$GridContainer/CenterContainer7/ReceiverCall7/ReceiverNumber/Label,
	$GridContainer/CenterContainer8/ReceiverCall8/ReceiverNumber/Label
]

func _ready():
	pass

func fill_receiver_numbers(list):
	for i in range(list.size()):
		receiver_lists[i].text = list[i]