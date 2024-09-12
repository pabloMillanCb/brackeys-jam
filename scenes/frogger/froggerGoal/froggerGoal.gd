extends Area2D

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if $".".has_overlapping_bodies():
		SignalManager.froggerEnd.emit()
