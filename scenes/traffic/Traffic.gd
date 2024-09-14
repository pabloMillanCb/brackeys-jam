extends Node2D

func _ready():
	go_red()

func go_red():
	$Red.visible = true
	$Green.visible = false
	%CollisionShape2D.disabled = false
	
func go_green():
	$Red.visible = false
	$Green.visible = true
	%CollisionShape2D.disabled = true
	$GreenSound.play()


func _on_timer_timeout():
	go_green()
	print("TimerEnd")


func _on_on_go_area_body_entered(body):
	print("onGoActivated")
	$Timer.start()
	$OnGoArea/CollisionShape2D.disabled = true
