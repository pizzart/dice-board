extends Control

signal rolled
signal inventory_opened
var dice = 0
var rolling: bool
var side1 = preload("res://sprites/ui/dice/bigdice-1.png")
var side2 = preload("res://sprites/ui/dice/bigdice-2.png")
var side3 = preload("res://sprites/ui/dice/bigdice-3.png")
var side4 = preload("res://sprites/ui/dice/bigdice-4.png")
var side5 = preload("res://sprites/ui/dice/bigdice-5.png")
var side6 = preload("res://sprites/ui/dice/bigdice-6.png")
var sides = [side1, side2, side3, side4, side5, side6]
onready var dice_node = get_node("Margin/Dice")
onready var roll_btn = get_node("Margin/Roll")

func _ready():
	roll_btn.grab_focus()

func _on_roll_pressed():
	rolling = true
	$RollSFX.play()
	roll_btn.disabled = true
	dice_node.show()
	dice_node.get_node("Anim").play("shake")

	dice_node.texture = sides[0]
	yield(get_tree().create_timer(0.5), "timeout")

	dice_node.texture = sides[1]
	yield(get_tree().create_timer(0.38), "timeout")

	dice_node.texture = sides[2]
	yield(get_tree().create_timer(0.22), "timeout")

	dice_node.texture = sides[3]
	yield(get_tree().create_timer(0.1), "timeout")

	dice_node.texture = sides[4]
	yield(get_tree().create_timer(0.1), "timeout")

	dice_node.texture = sides[5]
	yield(get_tree().create_timer(0.1), "timeout")

	dice_node.texture = sides[0]
	yield(get_tree().create_timer(0.1), "timeout")

	emit_signal("rolled")
	rolling = false
	#roll_btn.disabled = false
	dice_node.texture = sides[dice]
	yield(get_tree().create_timer(1.0), "timeout")

	if not rolling:
		dice_node.hide()

func _on_inventory_pressed():
	emit_signal("inventory_opened")
