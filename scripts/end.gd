extends Control

func _on_Quit_pressed():
	get_tree().quit()

func _on_Endless_pressed():
	Global.map = 0
	get_tree().reload_current_scene()
