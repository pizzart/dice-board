extends TextureButton

var card: int = Cards.POTION

func _ready():
	texture_normal = load("res://sprites/cards/%s.png" % Cards.STATS[card]["name"])
