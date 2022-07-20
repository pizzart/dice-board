extends Node

enum {WORM, ROVER, MOUSE, SPIDER, BAT, SNAKE}
const ENEMIES = {
	WORM: {
		"hp": 3,
		"atk": 1,
		"def": 0,
	},
	ROVER: {
		"hp": 12,
		"atk": 2,
		"def": 2,
	},
	MOUSE: {
		"hp": 7,
		"atk": 2,
		"def": 1,
	},
	SPIDER: {
		"hp": 12,
		"atk": 2,
		"def": 2,
	},
	BAT: {
		"hp": 12,
		"atk": 3,
		"def": 1,
	},
	SNAKE: {
		"hp": 20,
		"atk": 3,
		"def": 3,
	},
}
const ENEMY_SPRITES = {
	WORM: preload("res://sprites/fight/chars/worm.png"),
	ROVER: preload("res://sprites/fight/chars/rover.png"),
	MOUSE: preload("res://sprites/fight/chars/mouse.png"),
	SPIDER: preload("res://sprites/fight/chars/spider.png"),
	BAT: preload("res://sprites/fight/chars/bat.png"),
	SNAKE: preload("res://sprites/fight/chars/snake.png"),
}
