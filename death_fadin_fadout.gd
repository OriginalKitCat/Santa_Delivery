extends ColorRect

var transparency_value = 0


func _physics_process(delta: float) -> void:
	if Data.deathfade_end and transparency_value > 0:
		transparency_value -= delta * 2
	elif Data.deathfade_begin and transparency_value < 1:
		transparency_value += delta * 2
	if Data.deathfade_end and transparency_value <= 0.0:
		Data.deathfade_end = false

	transparency_value = clamp(transparency_value, 0.0, 1.0)
	modulate = Color(1, 1, 1, transparency_value)
