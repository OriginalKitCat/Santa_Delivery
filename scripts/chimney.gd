extends StaticBody2D

var body_next_to_chimney = false

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("place_parcel") && body_next_to_chimney == true:
		print("santa uses dhl")
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Santa":
		body_next_to_chimney = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Santa":
		body_next_to_chimney = false
