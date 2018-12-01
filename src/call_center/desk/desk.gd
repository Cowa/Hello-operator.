extends TextureRect

onready var resistance_list = $ResistanceList/Container/Content
onready var propaganda_list = $PropagandaList/Container/Content

func _ready():
	pass

func fill_lists(propaganda_data, resistance_data):
	propaganda_list.text = ""
	for i in range(propaganda_data.size()):
		propaganda_list.text += propaganda_data[i]
		if i % 2 == 0:
			propaganda_list.text += " | "
		else:
			propaganda_list.text += "\n"
	
	resistance_list.text = ""
	for i in range(resistance_data.size()):
		resistance_list.text += resistance_data[i]
		if i % 2 == 0:
			resistance_list.text += " | "
		else:
			resistance_list.text += "\n"