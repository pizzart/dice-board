extends TextureRect

signal pressed(card)
signal released(card)
var card: int = Cards.SWORD
var holding: bool
var start_pos: Vector2

func _ready():
	texture = load("res://sprites/cards/%s.png" % Cards.STATS[card]["name"])

func _on_gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.pressed and not holding:
				start_pos = rect_position - event.global_position
				emit_signal("pressed", self)
			elif not event.pressed and holding:
				emit_signal("released", self)
			holding = event.pressed
	if event is InputEventMouseMotion:
		if holding:
			rect_global_position = event.global_position + start_pos

func align_to(position: Vector2):
	rect_global_position = position
