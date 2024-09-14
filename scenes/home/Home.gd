extends Node2D

@export var calm = true

func _ready():
	$AnimationPlayer.play("House")
	SignalManager.keyhole_collided.connect(func(): 
		print("keyholw collided")
		$AnimationPlayer.play("close_house"))
	if (calm):
		$OpenDoorTimer.start()

func door_open():
	$ExitTimer.start()
	$AnimationPlayer.play("House_open")
	$Open.play()


func _on_timer_timeout():
	door_open()


func _on_exit_timer_timeout():
	SignalManager.exit_home.emit()
	$CloseTimer.start()


func _on_close_timer_timeout():
	$AnimationPlayer.play("House")
	$Close.play()

func _player_disapear():
	SignalManager.player_disapear.emit()

func _on_enter_house():
	SignalManager.init_end.emit()
