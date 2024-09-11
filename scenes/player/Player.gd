extends CharacterBody2D


const SPEED = 300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var farnting_and_pooping = false
var foot = 2
var timer = 0
var value = 0

var playable = true

func _ready():
	SignalManager.enter_kebab.connect(func(): 
		visible = false)
	SignalManager.reached_kebab.connect(func(): 
		playable = false)
	SignalManager.exit_kebab.connect(func():
		visible = true
		%AnimationPlayer.play("Eat"))

func _input(_event):
	if Input.is_key_pressed(KEY_C):
		start_pooping()
		
func _physics_process(delta):
	if (playable):
		if(!farnting_and_pooping):
			walk_controls(delta)
		else:
			fart_and_poop_controls(delta)
		

func start_pooping():
	farnting_and_pooping = !farnting_and_pooping
	%AnimationPlayer.play("Run")
	%AnimationPlayer.seek(0, true)
	%AnimationPlayer.pause()
	%Camera2D.limit_right = 18785

func walk_controls(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		%AnimationPlayer.play("Walk")
		velocity.x = direction * SPEED
		if(direction == -1):
			%Sprite2D.flip_h = true
		else:
			%Sprite2D.flip_h = false
	else:
		%AnimationPlayer.stop()
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func fart_and_poop_controls(delta):
	timer += delta
	print(value/timer)
	if(timer > 2):
		timer = 0
		value = 0
	%Camera2D.position_smoothing_enabled = true
	%Camera2D.position.x = -300
	%Sprite2D.flip_h = true
	var pressed = Input.get_axis("ui_left", "ui_right")
	if pressed && foot == 2:
		foot = pressed
		foot = foot*-1
	if pressed == 1 && foot == -1:
		velocity.x = -SPEED*10
		move_and_slide()
		foot = foot*-1
		value += 1
		%AnimationPlayer.seek(0, true)
		%AnimationPlayer.pause()
	if pressed == -1 && foot == 1:
		velocity.x = -SPEED*10
		move_and_slide()
		foot = foot*-1
		value += 1
		%AnimationPlayer.seek(0.15, true)
		%AnimationPlayer.pause()
	
	velocity.x = 0


func _on_animation_player_animation_finished(anim_name):
	if (anim_name == 'Eat'):
		playable = true
		print('im finished')
		start_pooping()
