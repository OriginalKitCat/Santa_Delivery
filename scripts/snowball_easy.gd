extends CharacterBody2D

var pos: Vector2
var rota: float
var dir: float
var speed = 2000
var timer: Timer
var touched = true

func _ready() -> void:
	global_position = pos
	global_rotation = rota
	
	timer = Timer.new()
	add_child(timer)
	
	timer.wait_time = 5.0
	timer.one_shot = true
	timer.timeout.connect(self._on_timer_timeout)
	timer.start()

func _physics_process(_delta: float) -> void:
	#if touched:
		velocity = Vector2(speed, 0).rotated(dir)
		move_and_slide()
	

func _on_timer_timeout() -> void:
	print("Bullet timeout. Deleting node.")
	queue_free()

func _on_area_2d_body_exited(_body: Node2D) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name != "bullets" && body.name != "CharacterBody2D":
		print("Bullet touched something...")
		var banana = body.name
		print(banana)
		queue_free()
