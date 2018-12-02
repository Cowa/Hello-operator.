extends Control

func _ready():
	$AnimationPlayer.play("entrance")
	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play("ringing")

func _on_Button_pressed():
	$AnimationPlayer.play("leave")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene("res://src/call_center/CallCenter.tscn")
