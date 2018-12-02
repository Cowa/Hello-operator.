extends TextureRect

func update_time(time):
	var minutes = str(time / 60)
	var seconds = str(time % 60)
	
	if minutes.length() == 1:
		minutes = "0" + minutes
	if seconds.length() == 1:
		seconds = "0" + seconds
	
	$Digit1.text = minutes[0]
	$Digit2.text = minutes[1]
	$Digit3.text = seconds[0]
	$Digit4.text = seconds[1]	
