extends CharacterBody2D

const run_speed = 600.0
const jump_velocity = -600.0

var gun_towards_right = Vector2(-2, -124)
var gun_towards_left = Vector2(90, -124)  # Adjust the left gun position to be flipped horizontally
var coll_shape_1_to_r = Vector2(5.5, 29.41)
var coll_shape_2_to_r = Vector2(-15.75, -209.75)
var coll_shape_1_to_l = Vector2(73, 29.41)
var coll_shape_2_to_l = Vector2(100, -209.75)
var direction

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	Data.checkpoint_loc = global_position
	Data.start_loc = global_position
	$Gun.position = gun_towards_right  # Set the initial gun position

func _physics_process(delta: float) -> void:
	Data.currentplayerpos = global_position
	if Data.playerhealth <= 0:
		Data.was_killed = true
	if Data.was_killed == true:
		global_position = Data.checkpoint_loc
		Data.was_killed = false
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
		
	direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * run_speed
		$SantaPlaceholder.flip_h = (direction == -1)
		$AnimatedSprite2D.flip_h = (direction == -1)
		$AnimatedSprite2D.rotation = direction * -6.2
		if is_on_floor():
			$AnimatedSprite2D.play("walking")
		gunflip(direction)
		if direction == 1:
			$CollisionShape2D.position = coll_shape_1_to_r
			$CollisionShape2D2.position = coll_shape_2_to_r
		else:
			$CollisionShape2D.position = coll_shape_1_to_l
			$CollisionShape2D2.position = coll_shape_2_to_l
	else:
		velocity.x = move_toward(velocity.x, 0, run_speed)
		$AnimatedSprite2D.stop()
	move_and_slide()

func gunflip(rectanglefood: int) -> void:
	#var gun_sprite = $Gun.get_node("Sprite2D")
	if rectanglefood == 1:
		$Gun.position = gun_towards_right
		$Gun.scale.x = 1
	elif rectanglefood == -1:
		$Gun.position = gun_towards_left
		$Gun.scale.x = -1
