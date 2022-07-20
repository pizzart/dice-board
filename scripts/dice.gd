extends Spatial

func _process(delta):
	$Dice.rotation.y += delta / 2
	$Dice.rotation.x += delta / 4
	$Dice.rotation.z += delta / 4
