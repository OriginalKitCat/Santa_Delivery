extends Area2D

var pos: Vector2
var rota: float
var dir: float
var speed = 200
var timer: Timer
var touched = true
var velocity: Vector2

func _ready() -> void:
	global_position = pos
	global_rotation = rota
	
	timer = Timer.new()
	add_child(timer)
	
	timer.wait_time = 5.0
	timer.one_shot = true
	timer.timeout.connect(self._on_timer_timeout)
	timer.start()
	
	velocity = Vector2(speed, 0).rotated(dir)

func _physics_process(delta: float) -> void:
	global_position += velocity * delta
	

func _on_timer_timeout() -> void:
	print("Snowball timeout. Deleting node.")
	queue_free()

func _on_area_2d_body_exited(_body: Node2D) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	var whitelist = ["snowman", "roof", "santa", "chimney"]
	for item in whitelist:
		if body.name.to_lower().find(item) != -1:
			print("Snowball  touched a valid target...")
			var target_name = body.name
			print(target_name)
			queue_free()
			return


func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.name == "Santa":
		Data.playerhealth -= Data.easysnowman_damage
		queue_free()
	var whitelist = ["snowman", "roof", "santa", "chimney"]
	for item in whitelist:
		if body.name.to_lower().find(item) != -1:
			print("Bullet touched a valid target...")
			var target_name = body.name
			print(target_name)
			queue_free()
			return
