extends KinematicBody2D

var speed = 12
var dir = Vector2(0, -1)
var landed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var collision = self.move_and_collide(dir * speed)
	if collision != null && landed == false:
		collide(collision)

func collide(collision):
	dir = dir.bounce(collision.get_normal())
	if collision.get_collider().has_method("hit"):
		var hitState = collision.get_collider().hit()
		if hitState != 0:
			landed = true
			speed = 0
			self.get_parent().ball_landed(self)
			self.get_parent().connect("launcherReady", self, "_on_Launcher_LauncherReady")

func _on_Launcher_LauncherReady():
	queue_free()