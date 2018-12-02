extends Control

func _ready():
	var data = state.data
	var today = state.data.days[data.current_day]
	var title = $TextureRect/ResultTitle.text.replace("%D", str(data.current_day))
	
	$TextureRect/ResultTitle.text = title
	$TextureRect/SuccessfulCalls/Label.text = str(today.neutral_call)
	$TextureRect/PropagandaCalls/Label.text = str(today.propaganda_call)
	$TextureRect/ResistanceCalls/Label.text = str(today.resistance_call)
	$TextureRect/RejectedPropaganda/Label.text = str(today.rejected_propaganda)
	$TextureRect/RejectedResistance/Label.text = str(today.rejected_resistance)
	$TextureRect/MissedCalls/Label.text = str(today.missed_call)
	$TextureRect/FailedCall/Label.text = str(today.failed_call)
	
	var work_score = today.neutral_call + today.propaganda_call - today.resistance_call - today.rejected_propaganda + today.rejected_resistance - today.missed_call - today.failed_call
	$TextureRect/ScoreWork/Label.text = str(work_score)
	
	var saved_lives = today.resistance_call * 10 + 3 * (today.resistance_call / 2)
	$TextureRect/LiveSaved/Label.text = str(saved_lives)
	
	var sacrificed_lives = today.rejected_resistance * 10 + 3 * (today.rejected_resistance / 2)
	$TextureRect/LiveSacrificed/Label.text = str(sacrificed_lives)
	
	var propa_growth = today.propaganda_call * 3 + 2 * (today.propaganda_call / 3)
	$TextureRect/PropagandaGrowth/Label.text = str(propa_growth)
	
	var karma_score = saved_lives - sacrificed_lives - propa_growth
	$TextureRect/ScoreKarma/Label.text = str(karma_score)
	
	# Last day
	if data.current_day == 3:
		$TextureRect/NextDayButton/Label.text = "End"

func _on_NextDayButton_pressed():
	# Last day
	if state.data.current_day == 3:
		$AnimationPlayer.play("leave")
		yield($AnimationPlayer, "animation_finished")
		get_tree().change_scene("res://src/day_result/FinalResult.tscn")
		return
	state.data.current_day += 1
	
	$AnimationPlayer.play("leave")
	yield($AnimationPlayer, "animation_finished")
	
	get_tree().change_scene("res://src/call_center/CallCenter.tscn")

