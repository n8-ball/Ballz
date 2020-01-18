extends KinematicBody2D

var game
var hasGame = false

var sprite
var shakeAmount = 6
var shakeReturn = 2

var basePos = Vector2(0 , 0)
var value = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = self.find_node("Sprite")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if hasGame:
		self.global_position = game.brickPos + Vector2(basePos.x * game.brickSize, basePos.y * game.brickSize)
	display_value()
	pick_color()
	return_sprite()

func display_value():
	if value <= 0 && !hasGame:
		self.visible = false
	elif value <= 0:
		delete_self()
	else:
		self.visible = true

func pick_color():
	if value < 8:
		sprite.modulate = Color(1.0, 1.0, 1.0 - (value * 0.1))
	elif value < 16:
		sprite.modulate = Color(1.0, 1.0 - ((value - 8) * 0.1), 0.2)
	else:
		sprite.modulate = Color(1.0, 0.2, 0.2 + ((value - 16) * 0.1))

func return_sprite():
	if sprite.position != Vector2(0, 0):
		sprite.position += (Vector2(0, 0) - sprite.position).normalized() * shakeReturn
	if abs(sprite.position.distance_to(Vector2(0, 0))) < shakeReturn:
		sprite.position = Vector2(0, 0)

func set_game(newGame, multiplier):
	game = newGame
	hasGame = true
	value = game.score * multiplier
	game.connect("moveRow", self, "_on_Game_moveRow")

func set_pos(x, y):
	basePos = Vector2(x, y)

func delete_self():
	self.get_parent().remove_child(self)

func hit(dir):
	sprite.position = dir.normalized() * shakeAmount
	value -= 1
	return 0

func _on_Game_moveRow():
	basePos.y += 1
	