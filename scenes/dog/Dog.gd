extends Node2D

var player = null
var counter = 0

func _process(delta):
	if (player != null):
		global_position = player.global_position
		
		if (Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right")):
			counter += 1

func _on_area_2d_body_entered(body):
	player = body
	$AnimationPlayer.play("Bite")
	$Grr.play()
	$Area2D.queue_free()
	$Timer.start()
	SignalManager.dog_bite.emit()

func die():
	queue_free()

func _on_timer_timeout():
	if (counter < 8):
		counter = 0
	else:
		SignalManager.dog_release.emit()
		$AnimationPlayer.play("fly")
		$Timer.stop()
