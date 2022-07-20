extends Node

enum {START, NEUTRAL, ENEMY, BOSS, BONUS, END}
const FIRST = {
	0: {
		"pos": Vector2(0, 80),
		"type": START,
		"con": {0:1}
	},
	1: {
		"pos": Vector2(30, 40),
		"type": NEUTRAL,
		"con": {0:2, 6:6}
	},
	2: {
		"pos": Vector2(70, 30),
		"type": ENEMY,
		"con": {0:3},
		"enemies": [Enemies.WORM]
	},
	3: {
		"pos": Vector2(90, 60),
		"type": NEUTRAL,
		"con": {0:4, 5:6}
	},
	4: {
		"pos": Vector2(100, 30),
		"type": ENEMY,
		"con": {0:5},
		"enemies": [Enemies.MOUSE]
	},
	5: {
		"pos": Vector2(120, 40),
		"type": END,
		"con": {0:5}
	},
	6: {
		"pos": Vector2(60, 70),
		"type": BONUS,
		"con": {0:2, 6:0}
	},
}
const SECOND = {
	0: {
		"pos": Vector2(0, 60),
		"type": START,
		"con": {0:2, 6:3}
	},
	2: {
		"pos": Vector2(80, 30),
		"type": ENEMY,
		"con": {0:1},
		"enemies": [Enemies.WORM]
	},
	3: {
		"pos": Vector2(80, 60),
		"type": NEUTRAL,
		"con": {0:1}
	},
	1: {
		"pos": Vector2(125, 40),
		"type": END,
		"con": {0:1}
	},
}
const THIRD = {
	0: {
		"pos": Vector2(0, 60),
		"type": START,
		"con": {0:1}
	},
	1: {
		"pos": Vector2(20, 50),
		"type": NEUTRAL,
		"con": {0:2},
	},
	2: {
		"pos": Vector2(60, 45),
		"type": END,
		"con": {0:2}
	},
}
const FOURTH = {
	0: {
		"pos": Vector2(0, 50),
		"type": START,
		"con": {0:1}
	},
	1: {
		"pos": Vector2(40, 40),
		"type": NEUTRAL,
		"con": {0:2}
	},
	2: {
		"pos": Vector2(70, 50),
		"type": ENEMY,
		"con": {0:3},
		"enemies": [Enemies.WORM]
	},
	3: {
		"pos": Vector2(110, 45),
		"type": END,
		"con": {0:2}
	},
}
const FIFTH = {
	0: {
		"pos": Vector2(110, 60),
		"type": START,
		"con": {0:2}
	},
	2: {
		"pos": Vector2(90, 70),
		"type": ENEMY,
		"con": {0:3, 6:4},
		"enemies": [Enemies.MOUSE]
	},
	3: {
		"pos": Vector2(40, 40),
		"type": ENEMY,
		"con": {0:1, 5:4},
		"enemies": [Enemies.SPIDER]
	},
	4: {
		"pos": Vector2(30, 70),
		"type": BONUS,
		"con": {0:1}
	},
	1: {
		"pos": Vector2(0, 70),
		"type": END,
		"con": {0:1}
	},
}
const SIXTH = {
	0: {
		"pos": Vector2(10, 50),
		"type": START,
		"con": {0:2, 1:2, 2:2, 3:2, 4:3, 5:3, 6:3}
	},
	2: {
		"pos": Vector2(50, 70),
		"type": BONUS,
		"con": {0:1}
	},
	3: {
		"pos": Vector2(70, 50),
		"type": BONUS,
		"con": {0:1}
	},
	1: {
		"pos": Vector2(110, 60),
		"type": END,
		"con": {0:1}
	},
}
const SEVENTH = {
	0: {
		"pos": Vector2(0, 60),
		"type": START,
		"con": {0:1}
	},
	1: {
		"pos": Vector2(30, 30),
		"type": NEUTRAL,
		"con": {0:4, 1:3, 2:3}
	},
	3: {
		"pos": Vector2(30, 55),
		"type": ENEMY,
		"con": {0:0, 3:4, 4:4},
		"enemies": [Enemies.SPIDER, Enemies.BAT]
	},
	4: {
		"pos": Vector2(50, 50),
		"type": ENEMY,
		"con": {0:5},
		"enemies": [Enemies.BAT]
	},
	5: {
		"pos": Vector2(70, 60),
		"type": NEUTRAL,
		"con": {0:2, 3:6}
	},
	6: {
		"pos": Vector2(30, 70),
		"type": BONUS,
		"con": {0:0, 6:2}
	},
	2: {
		"pos": Vector2(90, 70),
		"type": END,
		"con": {0:2}
	},
}
const EIGHTH = {
	0: {
		"pos": Vector2(0, 50),
		"type": START,
		"con": {0:2}
	},
	2: {
		"pos": Vector2(20, 60),
		"type": ENEMY,
		"con": {0:3},
		"enemies": [Enemies.SPIDER]
	},
	3: {
		"pos": Vector2(40, 60),
		"type": ENEMY,
		"con": {0:4, 1:1, 2:1},
		"enemies": [Enemies.BAT, Enemies.SPIDER]
	},
	4: {
		"pos": Vector2(30, 40),
		"type": ENEMY,
		"con": {0:2},
		"enemies": [Enemies.SPIDER]
	},
	1: {
		"pos": Vector2(70, 70),
		"type": END,
		"con": {0:1}
	},
}
const NINETH = {
	0: {
		"pos": Vector2(120, 30),
		"type": START,
		"con": {0:1}
	},
	1: {
		"pos": Vector2(120, 60),
		"type": NEUTRAL,
		"con": {0:10, 4:11, 5:11, 6:11}
	},
	10: {
		"pos": Vector2(100, 70),
		"type": NEUTRAL,
		"con": {0:100, 1:101, 2:101, 3:101}
	},
	100: {
		"pos": Vector2(70, 80),
		"type": BONUS,
		"con": {0:-1}
	},
	101: {
		"pos": Vector2(60, 65),
		"type": NEUTRAL,
		"con": {0:110}
	},
	11: {
		"pos": Vector2(100, 45),
		"type": NEUTRAL,
		"con": {0:110, 1:111, 2:111, 3:111}
	},
	110: {
		"pos": Vector2(80, 55),
		"type": NEUTRAL,
		"con": {0:111}
	},
	111: {
		"pos": Vector2(60, 40),
		"type": ENEMY,
		"con": {0:0},
		"enemies": [Enemies.BAT, Enemies.SPIDER, Enemies.MOUSE]
	},
	-1: {
		"pos": Vector2(30, 70),
		"type": END,
		"con": {0:-1}
	},
}
const TENTH = {
	0: {
		"pos": Vector2(0, 30),
		"type": START,
		"con": {0:1}
	},
	1: {
		"pos": Vector2(30, 50),
		"type": BONUS,
		"con": {0:2},
	},
	2: {
		"pos": Vector2(60, 60),
		"type": BOSS,
		"con": {0:3},
		"enemies": [Enemies.SNAKE]
	},
	3: {
		"pos": Vector2(90, 40),
		"type": END,
		"con": {0:3},
	},
}
const ELEVENTH = {
	0: {
		"pos": Vector2(0, 60),
		"type": START,
		"con": {0:1}
	},
	1: {
		"pos": Vector2(30, 50),
		"type": BONUS,
		"con": {0:3, 6:2}
	},
	2: {
		"pos": Vector2(10, 30),
		"type": NEUTRAL,
		"con": {0:0}
	},
	3: {
		"pos": Vector2(60, 70),
		"type": BOSS,
		"con": {0:4},
		"enemies": [Enemies.ROVER]
	},
	4: {
		"pos": Vector2(80, 40),
		"type": END,
		"con": {0:4}
	},
}

const GRASS = preload("res://sprites/map/bg/map.png")
const CAVE = preload("res://sprites/map/bg/cave.png")
const FIGHT_GRASS = preload("res://sprites/fight/bg/fight_grass.png")
const FIGHT_CAVE = preload("res://sprites/fight/bg/fight_cave.png")
const MAPS = [THIRD, FOURTH, SECOND, FIRST, ELEVENTH, SIXTH, FIFTH, SEVENTH, EIGHTH, NINETH, TENTH]
const MAP_BGS = [GRASS, GRASS, GRASS, GRASS, GRASS, CAVE, CAVE, CAVE, CAVE, CAVE, CAVE]
const FIGHT_BGS = [FIGHT_GRASS, FIGHT_GRASS, FIGHT_GRASS, FIGHT_GRASS, FIGHT_GRASS, FIGHT_CAVE, FIGHT_CAVE, FIGHT_CAVE, FIGHT_CAVE, FIGHT_CAVE, FIGHT_CAVE]
