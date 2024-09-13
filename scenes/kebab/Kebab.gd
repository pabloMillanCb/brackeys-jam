extends Node2D

var exit_active = true

func _on_area_2d_body_entered(body):
	$AnimationPlayer.play('buy_kebab')
	$Area2D.queue_free()
	SignalManager.reached_kebab.emit()

func _on_kebab_entered():
	SignalManager.enter_kebab.emit()

func _on_exit_kebab():
	if(exit_active):
		SignalManager.exit_kebab.emit()
		exit_active = false
