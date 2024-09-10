extends CharacterBody2D


const SPEED = 300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var farnting_and_pooping = false
var foot = 2

func _input(event):
	if Input.is_key_pressed(KEY_C):
		farnting_and_pooping = !farnting_and_pooping
		
func _physics_process(delta):
	if(!farnting_and_pooping):
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()
	else:
		$Camera2D.position_smoothing_enabled = true
		$Camera2D.position.x = -300
		var pressed = Input.get_axis("ui_left", "ui_right")
		if pressed && foot == 2:
			foot = pressed
			foot = foot*-1
		if pressed == 1 && foot == -1:
			velocity.x = -SPEED*10
			move_and_slide()
			foot = foot*-1
		if pressed == -1 && foot == 1:
			velocity.x = -SPEED*10
			move_and_slide()
			foot = foot*-1
		
		velocity.x = 0
