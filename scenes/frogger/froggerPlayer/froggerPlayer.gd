extends CharacterBody2D

func _ready():
	SignalManager.froggerDeath.connect(frogger_death_received)
	SignalManager.froggerEnd.connect(frogger_end_received)
	
func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_left") && position.x > 50 && position.y <= 530 && position.y >= 130:
		position -= transform.x * 200
	if Input.is_action_just_pressed("ui_right") && position.x < 1050 && position.y <= 530 && position.y >= 130:
		position += transform.x * 200
	if Input.is_action_just_pressed("ui_up") && (position.y > 130 || (position.y > 30 && position.x == 550)):
		position -= transform.y * 200
	if Input.is_action_just_pressed("ui_down") && (position.y < 530 || (position.y < 730 && position.x == 550)):
		position += transform.y * 200

func frogger_death_received():
	position.x = 550
	position.y = 730
	%AudioStreamPlayer.play()
	
func frogger_end_received():
	print("sacabao")
