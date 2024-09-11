extends CharacterBody2D


const SPEED = 300.0
const MAX_SPEED = 2000.0
const IMPULSE = 400.0
const DECELERATION = 3600.0

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
	%Camera2D.limit_right = 18785
	%Camera2D.position_smoothing_enabled = true
	%Camera2D.position.x = -300
	%Sprite2D.flip_h = true

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
	if (Input.is_action_just_pressed('ui_left') or Input.is_action_just_pressed('ui_right')):
		velocity.x -= IMPULSE
		print('a')
	velocity.x += DECELERATION*delta
	velocity.x = clampf(velocity.x, -MAX_SPEED, 0)
	
	if (velocity.x < -1000):
		%AnimationPlayer.play("Max run")
	else:
		%AnimationPlayer.play("Run")
	
	move_and_slide()

func _on_animation_player_animation_finished(anim_name):
	if (anim_name == 'Eat'):
		playable = true
		print('im finished')
		start_pooping()
