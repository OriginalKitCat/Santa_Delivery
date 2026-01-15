extends ColorRect

var transparency_value := 0.0
var restarting := false

func _physics_process(delta: float) -> void:
	if Data.playerhealth <= 0 and not restarting:
		transparency_value += delta * 2

	if transparency_value >= 1.0 and not restarting:
		restarting = true
		restart_game()

	transparency_value = clamp(transparency_value, 0.0, 1.0)
	modulate.a = transparency_value

func restart_game() -> void:
	# reset autoload values if needed
	Data.playerhealth = 100
	Data.deathfade_begin = false
	Data.deathfade_end = false

	get_tree().reload_current_scene()
