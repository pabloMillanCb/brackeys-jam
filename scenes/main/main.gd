extends Node2D

var walking = true
var farting = false

func _ready():
	# We connect to the signal
	SignalManager.changeMap.connect(change_map_received)
	SignalManager.froggerStart.connect(frogger_start_received)
	SignalManager.froggerEnd.connect(frogger_end_received)
	SignalManager.enter_home.connect(enter_home_received)
	SignalManager.keyhole_collided.connect(keyhole_received)
	SignalManager.init_end.connect(house_entered)
	SignalManager.enter_kebab.connect(func(): walking = false)

func _process(delta):
	if (walking and !$City.playing):
		$City.play()
	elif (farting and !$Music.playing):
		$Music.play()
	
func change_map_received():
	$HappyMap.queue_free()
	$Music.play()
	# Now we load the next map
	$HorrorMap.visible = true
	$HorrorMap.process_mode = Node.PROCESS_MODE_ALWAYS

func frogger_start_received():
	print("puito")
	$Frogger.visible = true
	$Frogger.process_mode = Node.PROCESS_MODE_ALWAYS
	$HorrorMap.visible = false
	$HorrorMap.process_mode = Node.PROCESS_MODE_DISABLED
	
	
func frogger_end_received():
	$Frogger.visible = false
	$Frogger.process_mode = Node.PROCESS_MODE_DISABLED
	$HorrorMap.visible = true
	$HorrorMap.process_mode = Node.PROCESS_MODE_ALWAYS

func enter_home_received():
	$HorrorMap.visible = false
	$HorrorMap.process_mode = Node.PROCESS_MODE_DISABLED
	$LetMeIn.visible = true
	$LetMeIn.process_mode = Node.PROCESS_MODE_ALWAYS
	
func keyhole_received():
	$LetMeIn.visible = false
	$LetMeIn.process_mode = Node.PROCESS_MODE_DISABLED
	$HorrorMap.process_mode = Node.PROCESS_MODE_ALWAYS
	$HorrorMap/Player.position = Vector2(264, 504)
	$HorrorMap/Player.playable = false
	$HorrorMap.visible = true
	
func house_entered():
	var end = preload("res://scenes/endgame/Endgame.tscn").instantiate()
	$HorrorMap.queue_free()
	add_child(end)
	farting = false
	$Music.stop()
