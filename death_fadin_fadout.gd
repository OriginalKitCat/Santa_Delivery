extends ColorRect

var transparency_value = 0
var switch = false

func _physics_process(delta: float) -> void:
	if Data.deathfade && transparency_value <= 1:
		transparency_value += delta
	elif Data.deathfade && transparency_value > 1:
		switch = true
	elif Data.deathfade && switch:
		transparency_value -= delta
	elif Data.deathfade && transparency_value <= 0:
		transparency_value = 0
		switch = false
		Data.deathfade = false
	
	transparency_value = clamp(transparency_value, 0.0, 1.0)
	modulate = Color(1, 1, 1, transparency_value)
