extends Node2D

var game
var rng = RandomNumberGenerator.new()

const doubleBrickChance = 0.1 #Chance of a double value brick spawning
const normalBrickChance = 0.4 #Chance of a normal value brick spawning

var brickScene = preload("res://Scenes/Brick/Brick.tscn")
var collectScene = preload("res://Scenes/Ball/BallCollect.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	game = self.get_parent()
	game.connect("createFirstRow", self, "_on_Game_createFirstRow")
	game.connect("createRow", self, "_on_Game_createRow")
	rng.randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create_row(row):
	var numBricks = rng.randi_range(1, game.boardWidth - 1)
	var brickPos = get_pos(numBricks)
	
	instance_bricks(brickPos)
	if row != 1:
		instance_collector(brickPos)

func get_pos(numBricks):
	var brickPos = []
	for x in range(numBricks):
		var newPos = rng.randi_range(0, game.boardWidth - 1)
		while newPos in brickPos:
			newPos = rng.randi_range(0, game.boardWidth - 1)
		brickPos.append(newPos)
	return brickPos

func instance_bricks(brickPos):
	for x in range(len(brickPos)):
		var curBrick = brickScene.instance()
		curBrick.set_game(game)
		curBrick.set_pos(brickPos[x], 0)
		game.add_child(curBrick)

func instance_collector(brickPos):
	var newPos = rng.randi_range(0, game.boardWidth - 1)
	while newPos in brickPos:
		newPos = rng.randi_range(0, game.boardWidth - 1)
	var curCollector = collectScene.instance()
	curCollector.set_game(game)
	curCollector.set_pos(newPos, 0)
	game.add_collector(curCollector)

func _on_Game_createRow():
	create_row(0)

func _on_Game_createFirstRow():
	create_row(1)
