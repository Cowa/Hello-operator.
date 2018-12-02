extends Control

func _on_Button_pressed():
	$AnimationPlayer.play("leave")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene("res://src/call_center/CallCenter.tscn")
