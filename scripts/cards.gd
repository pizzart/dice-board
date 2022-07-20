extends Node

enum {NONE, SWORD, SPEAR, ROCK, STICK, POTION}
enum {WEAPON, CONSUMABLE}
const STATS = {
	NONE: {
		"name": "none",
		"hp": 0,
		"atk": 0,
		"def": 0,
		"consume": false,
		"type": WEAPON,
	},
	SWORD: {
		"name": "sword",
		"hp": 0,
		"atk": 2,
		"def": 1,
		"consume": false,
		"type": WEAPON,
	},
	SPEAR: {
		"name": "spear",
		"hp": 0,
		"atk": 2,
		"def": 0,
		"consume": false,
		"type": WEAPON,
	},
	ROCK: {
		"name": "rock",
		"hp": 0,
		"atk": 1,
		"def": 1,
		"consume": false,
		"type": WEAPON,
	},
	STICK: {
		"name": "stick",
		"hp": 0,
		"atk": 1,
		"def": 0,
		"consume": false,
		"type": WEAPON,
	},
	POTION: {
		"name": "potion",
		"hp": 5,
		"atk": 0,
		"def": 0,
		"consume": true,
		"type": CONSUMABLE,
	},
}
