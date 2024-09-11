extends Node2D


func _on_area_2d_body_entered(body):
	$AnimationPlayer.play('buy_kebab')
	$Area2D.queue_free()
	SignalManager.reached_kebab.emit()

func _on_kebab_entered():
	SignalManager.enter_kebab.emit()

func _on_exit_kebab():
	SignalManager.exit_kebab.emit()
