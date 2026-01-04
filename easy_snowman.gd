extends CharacterBody2D

const run_speed = 600.0
const jump_velocity = -600.0
var direction = 1
var health = 10
var shoot_at_player = false
var reloadtimer = randi() % 1 + 3
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	$HealthBar.value = health
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	movetoplayer()
	move_and_slide()

func movetoplayer():
	if Data.currentplayerpos.x < global_position.x:
		direction = 1
	elif Data.currentplayerpos.x > global_position.x:
		direction = -1
		$Snowman_image.flip_h   = (direction == -1)
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "bullets":
		health -= Data.bullet_damage
		sethealthbar()
	if health <= 0:
		queue_free()
		
func sethealthbar():
	$HealthBar.value = health

func _on_angry_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Santa":
		shoot_at_player = true

func _on_angry_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Santa":
		shoot_at_player = false
