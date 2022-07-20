extends Control

signal attacked
signal defended
signal consumed(card)
var card_button = preload("res://scenes/CardButton.tscn")
onready var title = get_node("ActMargin/ActV/Title")
onready var desc = get_node("ActMargin/ActV/Desc")
onready var enemy_hp_text = get_node("HPMargin/HPs/EnemyHP")
onready var player_hp_text = get_node("HPMargin/HPs/PlayerHP")

func _ready():
	get_node("ActMargin/ActV/Acts/Attack").grab_focus()
	for card in Global.equipped.keys():
		if Cards.STATS[Global.equipped[card]]["type"] == Cards.CONSUMABLE:
			var ui_card = card_button.instance()
			ui_card.card = Global.equipped[card]
			ui_card.connect("pressed", self, "_on_card_pressed", [ui_card, card])
			$ActMargin/ActV/Cards.add_child(ui_card)

func upd_hp(enemy, player):
	enemy_hp_text.text = "%sHP" % max(0, enemy)
	player_hp_text.text = "%sHP" % max(0, player)

func _on_defend_pressed():
	emit_signal("defended")
	$ActMargin.hide()

func _on_attack_pressed():
	emit_signal("attacked")
	$ActMargin.hide()

func _on_consume_pressed():
	if $ActMargin/ActV/Cards.get_child_count() > 0:
		$ActMargin/ActV/Cards.get_child(0).grab_focus()
		add_child(SoundPlayer.new_sound("res://audio/sfx/select.wav", 0.5))
	else:
		add_child(SoundPlayer.new_sound("res://audio/sfx/fail.wav", 0.5))
	#emit_signal("consumed")
	#$ActMargin.hide()

func _on_defend_focused():
	title.text = "DEFEND"
	title.modulate = Color("#3b7d4f")
	desc.text = "%s" % "reduces damage dealt by the enemy"
	add_child(SoundPlayer.new_sound("res://audio/sfx/select.wav", 0.5))
	$ActMargin/ActV/Cards.hide()

func _on_attack_focused():
	title.text = "ATTACK"
	title.modulate = Color("#e64539")
	desc.text = "%s" % "deals damage to the enemy"
	add_child(SoundPlayer.new_sound("res://audio/sfx/select.wav", 0.5))
	$ActMargin/ActV/Cards.hide()

func _on_consume_focused():
	title.text = "CONSUME"
	title.modulate = Color("#ff8933")
	desc.text = "%s" % "uses a card"
	add_child(SoundPlayer.new_sound("res://audio/sfx/select.wav", 0.5))
	$ActMargin/ActV/Cards.show()

func _on_card_pressed(ui_card, card):
	emit_signal("consumed", Global.equipped[card])
	Global.equipped[card] = Cards.NONE
	ui_card.queue_free()
	add_child(SoundPlayer.new_sound("res://audio/sfx/use_card.wav", 0.5))
	$ActMargin/ActV/Cards.hide()
	$ActMargin.hide()
