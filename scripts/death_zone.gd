extends Area2D

@onready var player
@onready var checkpoint_manager

var time_pressed = 0.0
var timer: Timer
var waittime = 0.6
var timerstarted = false
var alreadyPlaced = false

func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.wait_time = waittime
	timer.timeout.connect(_on_timer_timeout)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Santa" && Data.deathfade_begin == false:
		Data.was_killed = true
		Data.deathfade_begin = true
		Data.playerhealth -= 20
		print("Santa entered.")
		timer.start()
	


func _on_timer_timeout() -> void:
	Data.deathfade_begin = false
	Data.deathfade_end = true
