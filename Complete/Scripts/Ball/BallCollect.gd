extends Area2D

signal ballAdd

var game
var hasGame = false

var basePos = Vector2(0 , 0)

var moveSpeed = 5

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	self.global_position = Vector2(rng.randi_range(0, 1600), 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if hasGame:
		if self.global_position.distance_to(game.brickPos + Vector2(basePos.x * game.brickSize, basePos.y * game.brickSize)) < 1:
			self.global_position = game.brickPos + Vector2(basePos.x * game.brickSize, basePos.y * game.brickSize)
		elif self.global_position != basePos:
			self.global_position += (game.brickPos + Vector2(basePos.x * game.brickSize, basePos.y * game.brickSize) - self.global_position) * moveSpeed * delta
		var bodies = self.get_overlapping_bodies()
		if len(bodies) > 0 || basePos.y >= 9:
			emit_signal("ballAdd")
			queue_free()

func set_game(newGame):
	game = newGame
	hasGame = true
	game.connect("moveRow", self, "_on_Game_moveRow")
	game.connect("restartGame", self, "_on_Game_restartGame")

func set_pos(x, y):
	basePos = Vector2(x, y)

func _on_Game_moveRow():
	basePos.y += 1
	
func _on_Game_restartGame():
	queue_free()
