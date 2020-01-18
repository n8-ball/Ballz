extends Node2D

signal createFirstRow
signal createRow
signal moveRow
signal ballAdd

var score = 1
const brickPos = Vector2(542, 110)
const brickSize = 86
const boardWidth = 7
const boardHeight = 7

var launcherChild

var moveTime = 1
var moveTimer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	self.find_node("BallLauncher").connect("launcherReady", self, "_on_Launcher_LauncherReady")
	emit_signal("createFirstRow")
	emit_signal("moveRow")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_collector(collector):
	self.add_child(collector)
	collector.connect("ballAdd", self, "_on_BallCollect_BallAdd")

func end_game():
	self.get_tree().quit()

func _on_Launcher_LauncherReady():
	score += 1
	emit_signal("createRow")
	emit_signal("moveRow")

func _on_BallCollect_BallAdd():
	emit_signal("ballAdd")
