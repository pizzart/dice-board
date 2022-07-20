extends AudioStreamPlayer

enum {LOW, HIGH}
var low_hp = preload("res://audio/mus/battle_low_hp.wav")
var high_hp = preload("res://audio/mus/battle_high_hp.wav")
var queue = high_hp

func change_situation(hp: int):
	match hp:
		LOW:
			queue = low_hp
		HIGH:
			queue = high_hp

func _on_finished():
	stream = queue
	play()
