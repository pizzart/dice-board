extends Control

func _ready():
	Pause.can_pause = false
	AudioServer.set_bus_effect_enabled(2, 0, true)

func _on_play_pressed():
	get_tree().get_root().add_child(SoundPlayer.new_sound("res://audio/sfx/select.wav"))
	$Instruct.show()

func _on_quit_pressed():
	get_tree().get_root().add_child(SoundPlayer.new_sound("res://audio/sfx/select.wav"))
	yield(get_tree().create_timer(0.2), "timeout")
	get_tree().quit()

func _on_settings_toggled(button_pressed: bool):
	$M/Main/Buttons/Play.disabled = button_pressed
	$M/Main/Buttons/Quit.disabled = button_pressed
	$M/Settings.visible = button_pressed
	get_tree().get_root().add_child(SoundPlayer.new_sound("res://audio/sfx/select.wav"))

func _on_music_pressed():
	AudioServer.set_bus_mute(2, !AudioServer.is_bus_mute(2))
	var enabled = "ON"
	if AudioServer.is_bus_mute(2):
		enabled = "OFF"
	$M/Settings/Buttons/Music.text = "MUSIC: " + enabled
	get_tree().get_root().add_child(SoundPlayer.new_sound("res://audio/sfx/select.wav"))

func _on_sound_pressed():
	AudioServer.set_bus_mute(1, !AudioServer.is_bus_mute(1))
	var enabled = "ON"
	if AudioServer.is_bus_mute(1):
		enabled = "OFF"
	$M/Settings/Buttons/Sound.text = "SOUND: " + enabled
	get_tree().get_root().add_child(SoundPlayer.new_sound("res://audio/sfx/select.wav"))

func _on_Accept_pressed():
	get_tree().get_root().add_child(SoundPlayer.new_sound("res://audio/sfx/select.wav"))
	Pause.can_pause = true
	AudioServer.set_bus_effect_enabled(2, 0, false)
	get_tree().change_scene("res://scenes/Map.tscn")
