extends Area2D

@onready var player
@onready var checkpoint_manager

	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Santa":
		Data.was_killed = true
		Data.deathfade = true
		Data.playerhealth -= 20
		print("Santa entered.")
