extends Node2D


func _process(delta):
	if Input.is_key_pressed(KEY_ENTER):
		change_map();

func change_map():
	SignalManager.changeMap.emit();
