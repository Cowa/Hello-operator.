extends Line2D

onready var curve = $Curve.curve

func update():
	var curve_points = curve.get_baked_points()
	clear()
	
	for p in curve_points:
		add_point(p)

func clear():
	points = []