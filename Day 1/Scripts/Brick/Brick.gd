extends KinematicBody2D

var game
var hasGame = false

var pos = Vector2(0 , 0)
var value = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if hasGame:
		self.global_position = game.brickPos + Vector2(pos.x * game.brickSize, pos.y * game.brickSize)
	display_value()

func display_value():
	if value <= 0 && !hasGame:
		self.visible = false
	elif value <= 0:
		delete_self()
	else:
		self.visible = true

func set_game(newGame):
	game = newGame
	hasGame = true
	value = game.score
	game.connect("moveRow", self, "_on_Game_moveRow")

func set_pos(x, y):
	pos = Vector2(x, y)

func delete_self():
	self.get_parent().remove_child(self)

func hit():
	value -= 1
	return 0

func _on_Game_moveRow():
	pos.y += 1
	