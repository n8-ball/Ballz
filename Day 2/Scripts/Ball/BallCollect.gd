extends Area2D

signal ballAdd

var game
var hasGame = false

var pos = Vector2(0 , 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if hasGame:
		self.global_position = game.brickPos + Vector2(pos.x * game.brickSize, pos.y * game.brickSize)
		var bodies = self.get_overlapping_bodies()
		if len(bodies) > 0:
			print("Signal Emmitted")
			emit_signal("ballAdd")
			queue_free()

func set_game(newGame):
	game = newGame
	hasGame = true
	game.connect("moveRow", self, "_on_Game_moveRow")

func set_pos(x, y):
	pos = Vector2(x, y)

func _on_Game_moveRow():
	pos.y += 1
