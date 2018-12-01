extends Node

var propaganda_list = []
var resistance_list = []
var receiver_list = []

export(int) var resistance_list_size = 8
export(int) var propaganda_list_size = 6
var receiver_list_size = 8

func _ready():
	propaganda_list = generate_list(propaganda_list_size)
	resistance_list = generate_list(resistance_list_size)
	receiver_list = generate_list(receiver_list_size)

func generate_list(size):
	var list = []
	for i in range(size):
		var new_number = generate_number()
		while (new_number in list or is_already_generated(new_number)):
			print("Already have: " + new_number)
			new_number = generate_number()
		list.append(new_number)
	return list

func is_already_generated(number):
	return number in propaganda_list or number in resistance_list or number in receiver_list

func generate_number():
	randomize()
	return str(randi() % 10) + str(randi() % 10) + str(randi() % 10) + str(randi() % 10)

func generate_new_number():
	var new_number = generate_number()
	while is_already_generated(new_number):
		new_number = generate_number()
	return new_number