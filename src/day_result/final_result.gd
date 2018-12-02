extends "res://src/day_result/day_result.gd"

func _ready():
	var sum_work = 0
	var sum_karma = 0
	
	for i in range(state.data.days.size()):
		var today = state.data.days[i + 1]
		var work_score = today.neutral_call + today.propaganda_call - today.resistance_call - today.rejected_propaganda + today.rejected_resistance - today.missed_call - today.failed_call
		
		var saved_lives = today.resistance_call * 10 + 3 * (today.resistance_call / 2)
		var sacrificed_lives = today.rejected_resistance * 10 + 3 * (today.rejected_resistance / 2)
		var propa_growth = today.propaganda_call * 3 + 2 * (today.propaganda_call / 3)
	
		var karma_score = saved_lives - sacrificed_lives - propa_growth
		
		var workday = null
		var karmaday = null
		
		if i + 1 == 1:
			workday = $TextureRect/WorkDay1/Label
			karmaday = $TextureRect/KarmaDay1/Label
		elif i + 1 == 2:
			workday = $TextureRect/WorkDay2/Label
			karmaday = $TextureRect/KarmaDay2/Label
		else:
			workday = $TextureRect/WorkDay3/Label
			karmaday = $TextureRect/KarmaDay3/Label
		
		workday.text = str(work_score)
		karmaday.text = str(karma_score)
		
		sum_work += work_score
		sum_karma += karma_score
	
	$TextureRect/ScoreWork/Label.text = str(sum_work)
	$TextureRect/ScoreKarma/Label.text = str(sum_karma)