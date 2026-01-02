extends StaticBody2D

var body_next_to_chimney = false
var time_pressed = 0.0
var place_time = Data.timeToPlace
var timer: Timer
var waittime = 1.2
var timerstarted = false

func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	
	timer.wait_time = Data.weaponcooldown
	timer.one_shot = true
	timer.connect("timeout", _on_timer_timeout)
	timer.wait_time = waittime
	
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("place_parcel") and body_next_to_chimney:
		if Input.is_action_just_pressed("place_parcel"):
			Data.go_transparency_down = true
		print("santa uses dhl")
		if time_pressed < place_time:
			Data.place_bar_needed = true
			time_pressed += delta
			Data.place_timer = time_pressed
			print(time_pressed)
		if time_pressed >= place_time and not timerstarted:
			timer.start()
			timerstarted = true
			Data.go_transparency_up = true
			
	if not Input.is_action_pressed("place_parcel"):
		time_pressed = 0.0
		Data.place_bar_needed = false
		Data.go_transparency_down = false
		Data.go_transparency_up = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Santa":
		body_next_to_chimney = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Santa":
		body_next_to_chimney = false

func _on_timer_timeout() -> void:
	Data.place_bar_needed = false
	timerstarted = false
	Data.go_transparency_down = false
	Data.go_transparency_up = false
