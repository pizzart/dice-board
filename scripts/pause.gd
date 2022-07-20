extends CanvasLayer

var can_pause: bool = true

func _input(event):
	if event.is_action_pressed("pause") and can_pause:
		$Control.visible = !$Control.visible
		get_tree().paused = $Control.visible
