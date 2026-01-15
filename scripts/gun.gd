extends Area2D    

var bullet_path =preload("res://bullets.tscn")
var timer: Timer
var cooled_down: bool = true;
var fire_rota

func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	
	timer.wait_time = Data.weaponcooldown
	timer.one_shot = true
	timer.connect("timeout",  _on_timer_timeout)


func _physics_process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	fire_rota = rotation
	if scale.x < 0:
		rotation += PI
	if (Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) && (cooled_down == true) && Data.sugarcanecount > 0:
		fire()
		Data.sugarcanecount -= 1
		timer.start()
		cooled_down=false
		
func fire():
	var bullet=bullet_path.instantiate()
	bullet.dir = fire_rota
	bullet.pos = $Node2D.global_position  
	bullet.rota = global_rotation
	get_parent().add_child(bullet)


func _on_timer_timeout() -> void:
	cooled_down = true
