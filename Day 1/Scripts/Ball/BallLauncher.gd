extends Node2D

signal launcherReady

const HOLD_STATE = 0
const SHOOT_STATE = 1
const WAIT_STATE = 2
var state = HOLD_STATE

var maxAmmo = 1
var ammo = 0
var ballLanded = 0
var firstLand = false

var ballTimer = 0
var ballDelay = 0.1

var mouseClick = Vector2(0, 0)
var shootDir = Vector2(0, 0)

var newX = 800
const launcherY = 825

var game

# Declare member variables here. Examples:
var ballScene = preload("res://Scenes/Ball/Ball.tscn")

func _ready():
	game = self.get_parent()
	game.connect("ballAdd", self, "_on_BallCollect_BallAdd")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == HOLD_STATE:
		hold_state()
	elif state == SHOOT_STATE:
		shoot_state(delta)
	elif state == WAIT_STATE:
		wait_state()

func hold_state():
	self.global_position = Vector2(newX, launcherY)
	ammo = maxAmmo

func shoot_state(delta):
	ballTimer += delta
	if ballTimer >= ballDelay && ammo > 0:
		var newBall = ballScene.instance()
		newBall.dir = shootDir.normalized()
		self.add_child(newBall)
		ballTimer = 0
		ammo -= 1
	elif ammo <= 0:
		state = WAIT_STATE

func wait_state():
	if ballLanded >= maxAmmo:
		emit_signal("launcherReady")
		state = HOLD_STATE

func ball_landed(ball):
	if firstLand == false:
		firstLand = true
		newX = ball.global_position.x
	ballLanded += 1

func add_ball():
	ballLanded += 1
	maxAmmo += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if event is InputEventMouse && event.is_pressed() && state == HOLD_STATE:
		ballLanded = 0
		firstLand = false
		state = SHOOT_STATE
		mouseClick = event.position
		shootDir = mouseClick - self.global_position

func _on_BallCollect_BallAdd():
	print("gotSignal")
	add_ball()
