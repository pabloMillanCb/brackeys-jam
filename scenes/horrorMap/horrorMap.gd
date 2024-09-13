extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_semaphore_area_body_entered(body):
	print("ayuda")
	$Timer.start()
	$semaphore_area/CollisionShape2D.disabled = true


func _on_timer_timeout():
	SignalManager.froggerStart.emit();


func _on_timer_2_timeout():
	SignalManager.keyStart.emit();


func _on_home_area_body_entered(body):
	$Timer2.start()
	$home_area/CollisionShape2D.disabled = true
