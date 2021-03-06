extends KinematicBody2D

var game
var hasGame = false

var particles

var sprite
var shakeDir
var shakeAmount = 12
var shakeReturn = 1

var brickColor =  Color(255, 255, 255)
var colorSeed

var basePos = Vector2(0 , 0)
var value = 0

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = self.find_node("Sprite")
	particles = self.find_node("Particles")
	rng.randomize()
	colorSeed = rng.randf_range(0, 1.0)

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
	brickColor.h = (0.02 * value) + colorSeed
	brickColor.s = 0.9
	brickColor.v = 0.9
	
	sprite.modulate = brickColor

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
	particles.gravity = shakeDir
	particles.color = brickColor
	particles.emitting = true
	particles.rotation = shakeDir.angle()
	self.remove_child(particles)
	self.get_parent().add_child(particles)
	particles.position = self.global_position
	self.get_parent().remove_child(self)

func hit(dir):
	shakeDir = dir.normalized()
	sprite.position = shakeDir * shakeAmount
	value -= 1
	return 0

func _on_Game_moveRow():
	basePos.y += 1
	