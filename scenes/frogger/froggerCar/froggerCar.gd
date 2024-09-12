extends Area2D

@export var left_to_right:bool
@export var speed:float
# Called when the node enters the scene tree for the first time.
func _ready():
	if(left_to_right):
		$Sprite2D.flip_h = true
	$Sprite2D/AnimationPlayer.play("default")
	var normalize = (speed-0.5)/5.5
	$Sprite2D/AnimationPlayer.speed_scale = normalize

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
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
