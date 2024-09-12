extends Sprite2D

var original_position
var time_passed = 0.0
var move_up_down_speed = 5.0
var shake_intensity = 30.0
var is_moving_left = false
var move_speed = 3000

func _ready():
	original_position = position  # Save the original position
	$Area2D.connect("area_entered", Callable(self, "_on_area_entered"))
	

func _process(delta):
	if not is_moving_left:
		time_passed += delta
		var new_y = original_position.y + sin(time_passed * move_up_down_speed) * 320
		var shake_x = randf() * shake_intensity - (shake_intensity / 2)
		position = Vector2(original_position.x + shake_x, new_y)
		
	if Input.is_action_just_pressed("ui_left"):  # "Space" pressed
		is_moving_left = true

	if is_moving_left:
		position.x -= move_speed * delta
		if position.x < -texture.get_size().x:
			queue_free()  

# Area2D collision handler
func _on_area_entered(area):
	print(area)
	if area.name == "keyHoleArea":  # If it collides with the keyHole
		SignalManager.emit_signal("keyhole_collided")  # Emit signal to signal manager
		move_speed = 0
		$"../keyHoleAnim".play("Depierto");
		$"../keyHoleAnim2".play("Depierto");
	
	elif area.name == "Area2D":  # If it collides with the other Area2D
		_reset_position()
		_trigger_sounds()

# Reset the position and re-enable movement
func _reset_position():
	position = original_position
	is_moving_left = false

func _trigger_sounds():
	$"../KeyClank".play();

func _on_key_clank_finished():
	$"../Fart".play();
