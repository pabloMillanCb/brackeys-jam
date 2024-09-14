extends Node2D

var progress = 0.0
var zoom_speed = 0.005
var zoom_in_max = Vector2(3.0, 3.0)
var zoom_out_min = Vector2(1.0, 1.0)
var progress_max = 100.0
var key_pressed_time = 0.0
var zoom_delay = 1.0
var last_key = ""
var you_win = false;
@onready var camera_tween = get_tree().create_tween()
@onready var player = $Toilet/ToiletMan
@onready var camera = $Camera2D

func _process(delta):
	if !you_win and !$Black.visible:
		
		if (progress > 60.0 and progress < 100.0 and key_pressed_time < zoom_delay/4):
			$AnimationPlayer.play("caca2")
		elif (progress > 0 and key_pressed_time < zoom_delay/4):
			$AnimationPlayer.play("caca1")
		elif (progress < 100):
			$AnimationPlayer.stop()
			
		handle_input(delta)
		handle_zoom(delta)
		handle_progress(delta)

func handle_input(delta):
	if Input.is_action_just_pressed("ui_left"):
		print(progress)
		last_key = "left"
		key_pressed_time = 0.0
		apply_spring_compression()
		zoom_in_camera()
	elif Input.is_action_just_pressed("ui_right"):
		last_key = "right"
		key_pressed_time = 0.0
		apply_spring_compression()
		zoom_in_camera()
		print(progress)
	else:
		key_pressed_time += delta


func handle_zoom(delta):
	if key_pressed_time > zoom_delay:
		zoom_out_camera()

func handle_progress(delta):
	if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
		progress += 2
		play_clank()
		if progress >= progress_max:
			win_game()
	else:
		if key_pressed_time > zoom_delay:
			progress -= delta * 10
			progress = clamp(progress, 0, progress_max)

func apply_spring_compression():
	var compress_scale = Vector2(1.0, 0.8)  # Compress vertically
	var normal_scale = Vector2(1.0, 1.0)    # Normal scale
	
	var tween = get_tree().create_tween()
	tween.tween_property(player, "scale", compress_scale, 0.1)  # Compress vertically
	tween.tween_property(player, "scale", normal_scale, 0.2)    # Expand back to normal


func zoom_in_camera():
	var tween = get_tree().create_tween()
	tween.tween_property(camera, "zoom", zoom_in_max, 10.0)
	#camera.zoom = Vector2(progress/100+1, progress/100+1)


func zoom_out_camera():
	var tween = get_tree().create_tween()
	tween.tween_property(camera, "zoom", zoom_out_min, 3.0)
	#camera.zoom = Vector2(progress/100+1, progress/100+1)


func win_game():
	you_win = true
	progress = progress_max
	var tween = get_tree().create_tween()
	#tween.tween_property(camera, "zoom", zoom_out_min, 1.0)
	print("You win!")
	#$Song.start()
	$AnimationPlayer.play("caca3")
	camera.zoom = Vector2(1, 1)
	$EndSong.play()

func play_final_fart():
	$FinalFart.play()
	$Bomb.play()

func show_credits():
	$Black.visible = true
	$CanvasLayer.visible = true
	$Credits2.start()

func play_clank():
	var pitch = randf_range(0.8, 1.2)
	$Clank.pitch_scale = pitch
	$Clank.play()

func _on_song_timeout():
	$AnimationPlayer.play("caca3")
	camera.zoom = Vector2(1, 1)


func _on_credits_2_timeout():
	%Credits_2.queue_free()
