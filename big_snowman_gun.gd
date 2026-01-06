extends Area2D    

var bullet_path =preload("res://snowball_hard.tscn")
var timer: Timer

func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	
	timer.wait_time = randfn(4, 6.5)
	timer.one_shot = true
	timer.connect("timeout",  _on_timer_timeout)
	timer.start()


func _physics_process(_delta: float) -> void:
	look_at(Data.currentplayerpos) 
		
func fire():
	if get_parent().shoot_at_player:
		var bullet=bullet_path.instantiate()
		bullet.dir = rotation
		bullet.pos = $Node2D.global_position  
		bullet.rota = global_rotation
		get_parent().add_child(bullet)


func _on_timer_timeout() -> void:
	fire()
	timer.start()
	
