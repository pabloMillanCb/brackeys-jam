extends Node2D

var animation_playing = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(animation_playing):
		$Sprite2D2.global_scale = $Sprite2D2.global_scale + Vector2(0.01, 0.01)
	pass


func _on_animation_player_animation_finished(anim_name):
	$".".visible = false
	SignalManager.sakuga_end.emit()


func _on_animation_player_animation_started(anim_name):
	animation_playing = true
