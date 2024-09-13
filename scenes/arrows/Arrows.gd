extends Node2D

func _process(delta):
	if ((Input.is_action_just_pressed("ui_right") or Input.is_action_just_pressed("ui_right")) and %Timer.time_left == 0):
		queue_free()
		print("aaa")
