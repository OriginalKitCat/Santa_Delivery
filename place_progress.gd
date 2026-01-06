extends Control

var transparency_value = 0

func _ready() -> void:
	$ProgressBar.max_value = Data.timeToPlace
	if !Data.place_bar_needed:
		visible = false

func _physics_process(delta: float) -> void:
	if Data.go_transparency_up:
		transparency_value -= delta
		print("go_transparency_up is true")
	elif Data.go_transparency_down:
		transparency_value += delta
		print("go_transparency_down is true")
	
	transparency_value = clamp(transparency_value, 0.0, 1.0)
	modulate = Color(1, 1, 1, transparency_value)

	if Data.place_bar_needed:
		visible = true
	else:
		visible = false
	
	$ProgressBar.value = Data.place_timer
