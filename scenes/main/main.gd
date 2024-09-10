extends Node2D

var simultaneous_scene = preload("res://scenes/horrorMap/horrorMap.tscn").instantiate()

func _ready():
	# We connect to the signal
	SignalManager.changeMap.connect(change_map_received)

func _process(delta):
	return

func change_map_received():
	$".".queue_free()
	# Now we load the next map
	get_tree().root.add_child(simultaneous_scene);
