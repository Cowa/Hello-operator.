extends Node

func random(number):
	randomize()
	return randi() % number

func odds(number):
	return random(number) == 0

func choose(choices):
	randomize()
	var rand_index = randi() % choices.size()
	return choices[rand_index]