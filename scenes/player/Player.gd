extends CharacterBody2D


const SPEED = 400.0
var MAX_SPEED = 2000.0
const IMPULSE = 750.0
const DECELERATION = 4000.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var farnting_and_pooping = false
var foot = 2
var timer = 0
var value = 0
var current_speed = 0
var camera_zoom = 1
var target_zoom = 1

var playable = true

func _ready():
	SignalManager.enter_kebab.connect(func(): 
		visible = false)
	SignalManager.reached_kebab.connect(func(): 
		playable = false)
	SignalManager.exit_kebab.connect(func():
		if(!farnting_and_pooping):
			print("bruh")
			visible = true
			%AnimationPlayer.play("Eat")
		else:
			farnting_and_pooping = true
			visible = true
			playable = true)
	SignalManager.exit_home.connect(func():
		visible = true
		playable = true
		)
	SignalManager.froggerStart.connect(func():
		visible = false
		playable = false
		position.x = 10600
		%Camera2D.enabled = false
		)
	SignalManager.froggerEnd.connect(func():
		visible = true
		playable = true
		%Camera2D.enabled = true
		)
	SignalManager.dog_bite.connect(func():
		MAX_SPEED = 400.0
		%AnimationPlayer.play("Max run")
		)
	SignalManager.dog_release.connect(func():
		MAX_SPEED = 2000.0
		%AnimationPlayer.play("Run"))
	SignalManager.changeMap.connect(func():
		playable = false
		$Camera2D/Randomsakuga.visible = true
		$Camera2D/Randomsakuga/AnimationPlayer.play("default"))
	SignalManager.sakuga_end.connect(func():
		playable = true)
	if (!farnting_and_pooping):
		visible = false
		playable = false
	else:
		start_pooping()
		
	SignalManager.player_disapear.connect(func(): visible = false)

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
	%AnimationPlayer.play("Run")
	%Camera2D.limit_right = 21000
	%Camera2D.position.x = -300
	%Sprite2D.flip_h = true
	%Camera2D.position_smoothing_enabled = false

func walk_controls(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		%AnimationPlayer.play("Walk")
		current_speed += delta*1500.0
		current_speed = min(current_speed, SPEED)
		velocity.x = direction * current_speed
		if(direction == -1):
			%Sprite2D.flip_h = true
		else:
			%Sprite2D.flip_h = false
	else:
		%AnimationPlayer.stop()
		current_speed = 0
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func make_footstep():
	if (playable):
		var pitch = randf_range(0.8, 1.2)
		%Step.pitch_scale = pitch
		%Step.play()
	
func fart_and_poop_controls(delta):
	if (Input.is_action_just_pressed('ui_left') or Input.is_action_just_pressed('ui_right')):
		velocity.x -= IMPULSE
		var pitch = randf_range(0.8, 1.2)
		%RunStep.pitch_scale = pitch
		%RunStep.play()

	velocity.x += DECELERATION*delta
	velocity.x = clampf(velocity.x, -MAX_SPEED, 0)


	#if (absf(camera_zoom - target_zoom) < 0.08):
	#	camera_zoom = target_zoom
	#elif (camera_zoom < target_zoom):
	#	camera_zoom += delta
	#elif (camera_zoom > target_zoom):
	#	camera_zoom -= delta
	
	#%Camera2D.zoom = Vector2(camera_zoom, camera_zoom)

	#if (velocity.x < -1000):
	#	%AnimationPlayer.play("Max run")
	#else:
	#	%AnimationPlayer.play("Run")
	
	move_and_slide()

func _on_animation_player_animation_finished(anim_name):
	if (anim_name == 'Eat'):
		playable = true
		print('im finished')
		SignalManager.changeMap.emit()

func normalize_exponential(value: float, min_value: float, max_value: float, base: float, target_min: float, target_max: float) -> float:

	var linear_normalized = (value - min_value) / (max_value - min_value)
	

	var exponential_value = pow(base, linear_normalized) - 1  # Ajustamos restando 1 para que el rango esté en 0 a algo mayor a 1
	

	var exp_min = pow(base, 0) - 1  # Exponente mínimo
	var exp_max = pow(base, 1) - 1  # Exponente máximo
	var normalized_exponential = (exponential_value - exp_min) / (exp_max - exp_min)  # Normalizamos exponencialmente entre 0 y 1
	

	var scaled_value = target_min + (normalized_exponential * (target_max - target_min))
	
	return scaled_value


func _on_camera_zoom_timer_timeout():
	target_zoom = normalize_exponential(-velocity.x, 0, MAX_SPEED, 100, 1.0, 1.2)
