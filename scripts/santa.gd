extends CharacterBody2D

const run_speed = 600.0
const jump_velocity = -600.0

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
 

func _ready() -> void:
	Data.checkpoint_loc = global_position
	Data.start_loc = global_position
	

func  _physics_process(delta: float) -> void:
	Data.currentplayerpos = global_position
	if Data.was_killed == true:
		global_position = Data.checkpoint_loc
		Data.was_killed = false;
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
		
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * run_speed
		$SantaPlaceholder.flip_h = (direction == -1)
	else:
		velocity.x =move_toward(velocity.x, 0, run_speed)
	move_and_slide()
	move_and_slide()
