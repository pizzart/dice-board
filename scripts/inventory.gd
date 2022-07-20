extends Control

var big_card = preload("res://scenes/Card.tscn")
var none_card = preload("res://scenes/NoneCard.tscn")
var cards = {}
onready var inventory_node = get_node("M/V/Inventory")
onready var equipped_node = get_node("M/V/Equipped")

func _ready():
	var i = 0
	for card in Global.inventory.values():
		if card != Cards.NONE:
			var ui_card = big_card.instance()
			ui_card.card = card
			#ui_card.connect("pressed", self, "_on_card_pressed")
			ui_card.connect("released", self, "_on_card_released")
			ui_card.connect("mouse_entered", self, "_on_card_hovered", [card])
			ui_card.connect("mouse_exited", self, "_on_card_unhovered")
			$Cards.add_child(ui_card)
			cards[ui_card] = ["inventory", i]
			ui_card.align_to(inventory_node.get_child(i).rect_global_position)
		i += 1
	i = 0
	for card in Global.equipped.values():
		if card != Cards.NONE:
			var ui_card = big_card.instance()
			ui_card.card = card
			#ui_card.connect("pressed", self, "_on_card_pressed")
			ui_card.connect("released", self, "_on_card_released")
			ui_card.connect("mouse_entered", self, "_on_card_hovered", [card])
			ui_card.connect("mouse_exited", self, "_on_card_unhovered")
			$Cards.add_child(ui_card)
			cards[ui_card] = ["equipped", i]
			ui_card.align_to(equipped_node.get_child(i).rect_global_position)
		i += 1

func _on_card_hovered(card):
	var desc_text = Cards.STATS[card]["name"].to_upper() + ":"

	for stat in Cards.STATS[card].keys():
		if stat in ["hp", "atk", "def"] and Cards.STATS[card][stat] != 0:
			var plus = "+"
			if Cards.STATS[card][stat] < 0:
				plus = "—"
			desc_text += " %s%s%s" % [plus, Cards.STATS[card][stat], stat.to_upper()]

	if Cards.STATS[card]["type"] == Cards.CONSUMABLE:
		desc_text += ", CONSUMABLE"

	$M/V/Desc.text = desc_text
	$M/V/Desc.show()

func _on_card_unhovered():
	$M/V/Desc.hide()

func _on_card_released(card):
	var inv_dist = card.rect_global_position.distance_to(inventory_node.rect_global_position)
	var equip_dist = card.rect_global_position.distance_to(equipped_node.rect_global_position)

	var type
	var closest
	if inv_dist <= equip_dist:
		closest = inventory_node
		type = "inventory"
	else:
		closest = equipped_node
		type = "equipped"
	
	var lowest_dist = [10000, 0]
	for nonec in closest.get_children():
		var dist = card.rect_global_position.distance_to(nonec.rect_global_position)
		if dist < lowest_dist[0]:
			lowest_dist = [dist, nonec.get_index()]
	var index = lowest_dist[1]

	var used_indexes = {
		"inventory": [],
		"equipped": [],
	}
	for c in cards.values():
		used_indexes[c[0]].append(c[1])
	if index in used_indexes[type]:
		var free_idx = 0
		while free_idx in used_indexes[type]:
			free_idx += 1
			if free_idx > 4:
				free_idx = -1
				break

		if free_idx != -1:
			index = free_idx
		else:
			if type == "inventory":
				closest = equipped_node
				type = "equipped"
				free_idx = 0
				while free_idx in used_indexes[type]:
					free_idx += 1
				index = free_idx
			else:
				closest = inventory_node
				type = "inventory"
				free_idx = 0
				while free_idx in used_indexes[type]:
					free_idx += 1
				index = free_idx

	cards[card] = [type, index]
	card.align_to(closest.get_child(index).rect_global_position)

	var empty = {
		0: Cards.NONE,
		1: Cards.NONE,
		2: Cards.NONE,
		3: Cards.NONE,
		4: Cards.NONE,
	}
	Global.inventory = empty.duplicate()
	Global.equipped = empty.duplicate()
	for c in cards.keys():
		if cards[c][0] == "inventory":
			Global.inventory[cards[c][1]] = c.card
		else:
			Global.equipped[cards[c][1]] = c.card
