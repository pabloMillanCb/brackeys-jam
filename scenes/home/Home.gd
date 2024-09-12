extends Node2D

@export var calm = true

func _ready():
	$AnimationPlayer.play("House")
	if (calm):
		$OpenDoorTimer.start()

func door_open():
	$ExitTimer.start()
	$AnimationPlayer.play("House_open")


func _on_timer_timeout():
	door_open()


func _on_exit_timer_timeout():
	SignalManager.exit_home.emit()
	$CloseTimer.start()


func _on_close_timer_timeout():
	$AnimationPlayer.play("House")
