extends TextureProgress

var current_meter = 0

func update_meter(new_meter):
	#current_meter = new_meter
	$Tween.interpolate_property(self, "value", value, new_meter, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()

