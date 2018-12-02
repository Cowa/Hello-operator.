extends Node

func empty_day():
	return {
			neutral_call = 1,
			propaganda_call = 2,
			resistance_call = 3,
			rejected_propaganda = 4,
			rejected_resistance = 5,
			missed_call = 6
		}

var data = {
	current_day = 1,
	days = {
		1: empty_day(),
		2: empty_day(),
		3: empty_day(),
		4: empty_day(),
		5: empty_day()
	}
}