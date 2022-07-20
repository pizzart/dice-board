extends Node

var map = 0
var map_pos = 0
var player = {
	"hp": 5,
	"atk": 1,
	"def": 2,
	"block": false,
	"node": "Player",
}
var inventory = {
	0: Cards.NONE,
	1: Cards.NONE,
	2: Cards.NONE,
	3: Cards.NONE,
	4: Cards.NONE,
}
var equipped = {
	0: Cards.NONE,
	1: Cards.NONE,
	2: Cards.NONE,
	3: Cards.NONE,
	4: Cards.NONE,
}
