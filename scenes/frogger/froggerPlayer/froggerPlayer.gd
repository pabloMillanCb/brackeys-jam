extends CharacterBody2D

var target_position = Vector2.ZERO
var moving = false
var move_speed = 1200.0

func _ready():
	SignalManager.froggerDeath.connect(frogger_death_received)
	target_position = position
	
func _physics_process(delta):
	
	const LEFT_MARGIN_BOUND = 50

	if Input.is_action_just_pressed("ui_left") && position.x > LEFT_MARGIN_BOUND && position.y <= 530 && position.y >= 130:
		target_position -= transform.x * 200
		$Step.play()
		moving = true
	elif Input.is_action_just_pressed("ui_right") && position.x < 1050 && position.y <= 530 && position.y >= 130:
		target_position += transform.x * 200
		$Step.play()
		moving = true
	elif Input.is_action_just_pressed("ui_up") && (position.y > 130 || (position.y > 30 && position.x == 550)):
		target_position -= transform.y * 200
		$Step.play()
		moving = true
	elif Input.is_action_just_pressed("ui_down") && (position.y < 530 || (position.y < 730 && position.x == 550)):
		target_position += transform.y * 200
		$Step.play()
		moving = true
	else:
		var direction = (target_position - position).normalized()
		var distance_to_move = move_speed * delta
		if (position != target_position):
			position += direction * distance_to_move
			if (((target_position - position) as Vector2).length() < 10.0):
				position = target_position
				moving = false
		else:
			moving = false
		

func frogger_death_received():
	position.x = 550
	position.y = 730
	moving = false
	target_position = position
	%AudioStreamPlayer.play()
