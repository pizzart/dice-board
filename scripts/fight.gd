extends Node2D

signal fight_done(positive)
enum {ATTACK, DEFEND}
var player = Global.player.duplicate()
var bg = Maps.FIGHT_BGS[Global.map]
var rng = RandomNumberGenerator.new()
var enemy_index = Enemies.WORM
var enemy
var enemy_init_hp
onready var player_init_hp = player["hp"]

func _ready():
	rng.randomize()

	var enemies = Maps.MAPS[Global.map][Global.map_pos]["enemies"]
	enemy_index = rng.randi() % enemies.size()
	enemy = Enemies.ENEMIES[enemies[enemy_index]].duplicate()
	enemy_init_hp = enemy["hp"]
	enemy["block"] = false
	enemy["node"] = "Enemy"

	get_node("Enemy").texture = Enemies.ENEMY_SPRITES[enemies[enemy_index]]
	get_node("BG").texture = bg

	$UILayer/FightUI.connect("attacked", self, "_on_attacked")
	$UILayer/FightUI.connect("defended", self, "_on_defended")
	$UILayer/FightUI.connect("consumed", self, "_on_consumed")

	for card in Global.equipped.values():
		var stats = Cards.STATS[card]
		if stats["type"] != Cards.CONSUMABLE:
			player["hp"] += stats["hp"]
			player["atk"] += stats["atk"]
			player["def"] += stats["def"]

	$UILayer/FightUI.upd_hp(enemy["hp"], player["hp"])

func damage(attacker, attacked):
	if not attacked["block"]:
		add_child(SoundPlayer.new_sound("res://audio/sfx/attack.wav"), 0.8)
	else:
		add_child(SoundPlayer.new_sound("res://audio/sfx/attack_blocked.wav"))
	attacked["hp"] -= max(attacker["atk"] - attacked["def"] * int(attacked["block"]), 0)
	attacked["block"] = false
	get_node(attacked["node"] + "Block").visible = false
	get_node(attacked["node"]).get_node("Anim").play("shake")

func block(blocker):
	add_child(SoundPlayer.new_sound("res://audio/sfx/shield.wav"), 0.8)
	blocker["block"] = true
	get_node(blocker["node"] + "Block").visible = true

func consume(consumer, card):
	consumer["hp"] += card["hp"]
	consumer["atk"] += card["atk"]
	consumer["def"] += card["def"]

func do_turn():
	$UILayer/FightUI.upd_hp(enemy["hp"], player["hp"])

	var rand_stat = ["hp", "def"][rng.randi() % 2]
	if enemy["hp"] <= 0:
		Global.player[rand_stat] += 1
		$UILayer/FightUI/BuffMargin/Buff.text = "+1%s" % rand_stat.to_upper()
		$UILayer/FightUI/BuffMargin/Buff/Anim.play("default")

		$Music.stream_paused = true

		yield(get_tree().create_timer(0.5), "timeout")

		add_child(SoundPlayer.new_sound("res://audio/sfx/winbattle.wav"))

		var tween = Tween.new()
		tween.interpolate_property($Enemy, "position:y", $Enemy.position.y, -50, 1.0, Tween.TRANS_SINE, Tween.EASE_IN)
		add_child(tween)
		tween.start()

		yield(get_tree().create_timer(1.6), "timeout")
		get_tree().change_scene("res://scenes/Map.tscn")
		return

	yield(get_tree().create_timer(0.5), "timeout")

	enemy_do_action()
	$UILayer/FightUI.upd_hp(enemy["hp"], player["hp"])

	if player["hp"] <= ceil(player_init_hp / 2):
		$Music.change_situation($Music.LOW)
	else:
		$Music.change_situation($Music.HIGH)

	if player["hp"] <= 0:
		$Music.stream_paused = true
		Global.map_pos = 0
		Global.player[rand_stat] -= 1

		$UILayer/FightUI/BuffMargin/Buff.text = "—1%s" % rand_stat.to_upper()
		$UILayer/FightUI/BuffMargin/Buff/Anim.play("default")

		yield(get_tree().create_timer(0.5), "timeout")

		get_tree().get_root().add_child(SoundPlayer.new_sound("res://audio/sfx/losebattle.wav"))

		var tween = Tween.new()
		tween.interpolate_property($Player, "position:y", $Player.position.y, -50, 1.2, Tween.TRANS_SINE, Tween.EASE_IN)
		add_child(tween)
		tween.start()

		yield(get_tree().create_timer(2.8), "timeout")
		get_tree().change_scene("res://scenes/Map.tscn")

		return

	yield(get_tree().create_timer(0.5), "timeout")
	$UILayer/FightUI/ActMargin.show()
	$UILayer/FightUI/ActMargin/ActV/Acts/Attack.grab_focus()

func enemy_do_action():
	var enemy_action = rng.randf_range(0, 1)

	var block_chance = 0.3
	if enemy["hp"] < ceil(enemy_init_hp / 2):
		block_chance = 0.5

	var attack_if_blocked_chance = 0.8

	if enemy_action < block_chance and not enemy["block"]:
		block(enemy)
	elif not player["block"]:
		damage(enemy, player)
	elif enemy_action < attack_if_blocked_chance:
		damage(enemy, player)
	#else: stall

func _on_attacked():
	damage(player, enemy)
	do_turn()

func _on_defended():
	block(player)
	do_turn()

func _on_consumed(card):
	consume(player, Cards.STATS[card])
	do_turn()
