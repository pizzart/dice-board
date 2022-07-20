extends Node

func new_sound(path, volume: float = 1):
	var sound = AudioStreamPlayer.new()
	sound.stream = load(path)
	sound.autoplay = true
	sound.bus = "SFX"
	sound.volume_db = linear2db(volume)
	sound.connect("finished", self, "_on_sound_finished", [sound])
	return sound

func _on_sound_finished(sound):
	sound.queue_free()
