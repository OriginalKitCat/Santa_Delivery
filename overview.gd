extends Control

func _process(_delta: float) -> void:
	$caneNumber.text = str(Data.sugarcanecount)
	$presentsDelivered.text = str(Data.presentsDelivered)
	$health.text = str(Data.playerhealth)
