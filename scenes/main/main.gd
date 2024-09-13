extends Node2D

func _ready():
	# We connect to the signal
	SignalManager.changeMap.connect(change_map_received)
	SignalManager.froggerStart.connect(frogger_start_received)
	SignalManager.froggerEnd.connect(frogger_end_received)

func _process(delta):
	return
	
func change_map_received():
	$HappyMap.queue_free()
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
