extends Node

func empty_day():
	return {
			neutral_call = 0,
			propaganda_call = 0,
			resistance_call = 0,
			rejected_propaganda = 0,
			rejected_resistance = 0,
			missed_call = 0,
			failed_call = 0
		}

var data = {
	current_day = 1,
	days = {
		1: empty_day(),
		2: empty_day(),
		3: empty_day()
	}
}

func retry():
	data.days[data.current_day] = empty_day()

func inc_propaganda():
	data.days[data.current_day].propaganda_call += 1

func inc_resistance():
	data.days[data.current_day].resistance_call += 1

func inc_call():
	data.days[data.current_day].neutral_call += 1

func inc_rejected_propaganda():
	data.days[data.current_day].rejected_propaganda += 1

func inc_rejected_resistance():
	data.days[data.current_day].rejected_resistance += 1

func inc_missed_call():
	data.days[data.current_day].missed_call += 1

func inc_failed_call():
	data.days[data.current_day].failed_call += 1