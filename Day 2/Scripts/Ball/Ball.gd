extends KinematicBody2D

var speed = 1
const normSpeed = 12
const fastSpeed = 24
var fastForward = false
var dir = Vector2(0, -1)
var landed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	self.get_parent().connect("speedUp", self, "_on_Launcher_FastForward")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if fastForward && speed != 0:
		speed = fastSpeed
	elif speed != 0:
		speed = normSpeed
	var collision = self.move_and_collide(dir * speed)
	if collision != null && landed == false:
		collide(collision)
	fastForward = false

func collide(collision):
	var bounceDir = dir.bounce(collision.get_normal())
	if collision.get_collider().has_method("hit"):
		var hitState = collision.get_collider().hit(dir)
		if hitState != 0:
			landed = true
			speed = 0
			self.get_parent().ball_landed(self)
			self.get_parent().connect("launcherReady", self, "_on_Launcher_LauncherReady")
	dir = bounceDir

func _on_Launcher_LauncherReady():
	queue_free()

func _on_Launcher_FastForward():
	fastForward = true