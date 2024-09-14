extends Node2D


func _on_happy_dog_trigger_body_entered(body):
	show_happy_dog()

func show_happy_dog():
	print("dogo")
	if ($HouseWODog.visible == true):
		$AnimationPlayer.play("show_dog")
		$guau.play()
