extends Node2D

signal launcherReady
signal speedUp

const HOLD_STATE = 0
const SHOOT_STATE = 1
const WAIT_STATE = 2
var state = HOLD_STATE

var maxAmmo = 100
var ammo = 0
var ballLanded = 0
var firstLand = false

var ballTimer = 0
var ballDelay = 0.1

var mouseClick = Vector2(0, 0)
var shootDir = Vector2(0, 0)
var shootLeeway = 20
var fastForward = false

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
	if fastForward:
		emit_signal("speedUp")

func hold_state():
	self.global_position = Vector2(newX, launcherY)
	ammo = maxAmmo

func shoot_state(delta):
	if fastForward:
		ballTimer += delta*3
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
	mouseClick = event.position
	if event is InputEventMouse && event.is_pressed() && state == HOLD_STATE && mouseClick.y < self.global_position.y - shootLeeway:
		ballLanded = 0
		firstLand = false
		state = SHOOT_STATE
		shootDir = mouseClick - self.global_position
	if event is InputEventMouse && event.is_action_pressed("mouse_held") && (state == SHOOT_STATE || state == WAIT_STATE):
		fastForward = true
	if event is InputEventMouse && event.is_action_released("mouse_held"):
		fastForward = false

func _on_BallCollect_BallAdd():
	add_ball()
