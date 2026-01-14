extends StaticBody2D

var body_next_to_chimney = false
var time_pressed = 0.0
var timer: Timer
var waittime = 1.2
var timerstarted = false
var alreadyPlaced = false

func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.wait_time = waittime
	timer.timeout.connect(_on_timer_timeout)

func _physics_process(delta: float) -> void:
	#print(Data.presentsDelivered)
	if Input.is_action_pressed("place_parcel") and body_next_to_chimney and not alreadyPlaced:
		if Input.is_action_just_pressed("place_parcel"):
			Data.go_transparency_down = true

		if time_pressed < Data.timeToPlace:
			Data.place_bar_needed = true
			time_pressed += delta
			Data.place_timer = time_pressed

		elif not timerstarted:
			Data.go_transparency_down = false
			timer.start()
			Data.presentsDelivered += 1
			print(name + "Placed one present")
			alreadyPlaced = true
			timerstarted = true
			Data.go_transparency_up = true

	elif not timerstarted && body_next_to_chimney:
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
	timerstarted = false
	Data.place_bar_needed = false
	Data.go_transparency_down = false
	Data.go_transparency_up = false
	alreadyPlaced = true
