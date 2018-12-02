extends "res://src/day_result/day_result.gd"

func _ready():
	._ready()
	$TextureRect/NextDayButton/Label.text = "Retry"

func _on_NextDayButton_pressed():
	state.retry()
	
	$AnimationPlayer.play("leave")
	yield($AnimationPlayer, "animation_finished")
	
	get_tree().change_scene("res://src/call_center/CallCenter.tscn")
