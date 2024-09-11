extends Area2D

@export var left_to_right:bool
@export var speed:float
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if(left_to_right):
		position += transform.x * speed
		if position.x >= 1150:
			position.x = -50
	else:
		position -= transform.x * speed
		if position.x <= -50:
			position.x = 1150
	if $".".has_overlapping_bodies():
		SignalManager.froggerDeath.emit()
