extends Sprite2D

var amount = 4:
	get:
		return amount
	set(value):
		amount = value
		if amount > 4:
			amount = 4
		if amount < 0:
			amount = 0
		var x = amount * 8
		region_rect = Rect2(x, 16, 8, 8)
