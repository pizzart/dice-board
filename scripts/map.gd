extends Node2D

enum {START, NEUTRAL, ENEMY, BOSS, BONUS, END}
const ROAD_COLOR = Color("#3b2027")
const HIGHLIGHT_ROAD_COLOR = Color("#ab5130")
var pos_idx = 0
var inv
var map = Maps.MAPS[Global.map]
var bg = Maps.MAP_BGS[Global.map]
var rng = RandomNumberGenerator.new()
var inventory = preload("res://scenes/Inventory.tscn")
var font = preload("res://misc/font.tres")
var tile = preload("res://sprites/map/fg/tile.png")
var bag = preload("res://sprites/map/fg/bag.png")
var flag = preload("res://sprites/map/fg/flag.png")
var dice = preload("res://sprites/map/fg/dice.png")
var skull = preload("res://sprites/map/fg/skull.png")
var redskull = preload("res://sprites/map/fg/redskull.png")
var player = preload("res://sprites/map/fg/player.png")

var dice1 = preload("res://sprites/map/fg/dice/diceindicator1.png")
var dice2 = preload("res://sprites/map/fg/dice/diceindicator2.png")
var dice3 = preload("res://sprites/map/fg/dice/diceindicator3.png")
var dice4 = preload("res://sprites/map/fg/dice/diceindicator4.png")
var dice5 = preload("res://sprites/map/fg/dice/diceindicator5.png")
var dice6 = preload("res://sprites/map/fg/dice/diceindicator6.png")

var dices = [dice1, dice2, dice3, dice4, dice5, dice6]

func _ready():
	rng.randomize()
	pos_idx = Global.map_pos
	if map[pos_idx]["type"] == BOSS:
		$Music.stream_paused = true

func _draw():
	draw_texture(bg, Vector2())

	for point in map.values():
		var color = ROAD_COLOR
		if point == map[pos_idx]:
			color = HIGHLIGHT_ROAD_COLOR
		for num in point["con"].keys():
			var pos1 = point["pos"] + Vector2(8, 8)
			var pos2 = map[point["con"][num]]["pos"] + Vector2(8, 8)
			draw_line(pos1, pos2, color)

	for n in map.keys():
		var pos = map[n]["pos"]
		draw_texture(tile, pos)

		var offset_pos = pos + Vector2(4, 0)
		match map[n]["type"]:
			ENEMY:
				draw_texture(skull, offset_pos)
			BOSS:
				draw_texture(redskull, offset_pos)
			BONUS:
				draw_texture(bag, offset_pos)
			END:
				draw_texture(flag, offset_pos)

		#if map[n]["con"].size() > 1:
			#draw_texture(dice, pos + Vector2(-6, -2))

		if n == pos_idx:
			draw_texture(player, pos + Vector2(0, -3))

	var count = {}
	for point in map.values():
		for num in point["con"].keys():
			if point == map[pos_idx] and num != 0:
				var pos1 = point["pos"] + Vector2(8, 8)
				var pos2 = map[point["con"][num]]["pos"] + Vector2(8, 8)
				var dir = pos1.direction_to(pos2)
				if not count.has(point["con"][num]):
					count[point["con"][num]] = 0
				else:
					count[point["con"][num]] += 1
				var mult_offset = count[point["con"][num]] * 8
				draw_texture(dices[num - 1], pos1 + dir * 10 + Vector2(-6, -4) + dir * mult_offset)
				#draw_string(font, pos1 + dir * 10 + Vector2(-2, 2), str(num))

func _input(event):
	if event.is_action_pressed("show_inventory"):
		if inv == null:
			inv = inventory.instance()
			$UILayer.add_child(inv)
			$UILayer/MapUI.visible = false
		else:
			inv.queue_free()
			inv = null
			$UILayer/MapUI.visible = true

func _on_ui_rolled():
	var dice_num = rng.randi_range(0, 5)
	$UILayer/MapUI.dice = dice_num

	var connections = map[pos_idx]["con"]
	var next = connections.get(dice_num + 1, connections[0])
	pos_idx = next
	Global.map_pos = pos_idx
	update()

	match map[pos_idx]["type"]:
		BONUS:
			var found = false
			for n in Global.inventory.keys():
				if Global.inventory[n] == Cards.NONE:
					Global.inventory[n] = rng.randi_range(1, Cards.STATS.size() - 1)
					found = true
					break
			if not found:
				for n in Global.equipped.keys():
					if Global.equipped[n] == Cards.NONE:
						Global.equipped[n] = rng.randi_range(1, Cards.STATS.size() - 1)
						found = true
						break

			if found:
				add_child(SoundPlayer.new_sound("res://audio/sfx/bonus.wav"))
				yield(get_tree().create_timer(0.8), "timeout")
				inv = inventory.instance()
				$UILayer.add_child(inv)
				$UILayer/MapUI.visible = false
		ENEMY:
			$Music.stop()
			yield(get_tree().create_timer(0.8), "timeout")
			get_tree().get_root().add_child(SoundPlayer.new_sound("res://audio/sfx/enterbattle.wav"))
			$UILayer/MapUI.hide()
			yield(get_tree().create_timer(1.5), "timeout")
			get_tree().change_scene("res://scenes/Fight.tscn")
		BOSS:
			$Music.stop()
			yield(get_tree().create_timer(0.8), "timeout")
			get_tree().get_root().add_child(SoundPlayer.new_sound("res://audio/sfx/enterbattle.wav"))
			$UILayer/MapUI.hide()
			yield(get_tree().create_timer(1.5), "timeout")
			get_tree().change_scene("res://scenes/Fight.tscn")
		END:
			$Music.stop()
			yield(get_tree().create_timer(0.8), "timeout")
			get_tree().get_root().add_child(SoundPlayer.new_sound("res://audio/sfx/map_advance.wav"), 0.1)
			$UILayer/MapUI.hide()
			yield(get_tree().create_timer(1.5), "timeout")
			Global.map += 1
			Global.map_pos = 0
			if Global.map >= Maps.MAPS.size():
				$UILayer/End.show()
			else:
				get_tree().reload_current_scene()
	$UILayer/MapUI.roll_btn.disabled = false
