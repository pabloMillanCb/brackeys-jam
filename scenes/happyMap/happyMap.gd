extends Node2D


func _process(delta):
	pass

func change_map():
	SignalManager.changeMap.emit();
