extends Node2D

var mousePos = Vector2(0, 0)
var dir
var distance
var launcher
var numChildren

# Called when the node enters the scene tree for the first time.
func _ready():
	launcher = self.get_parent()
	numChildren = self.get_child_count()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if launcher.state != launcher.HOLD_STATE:
		self.visible = false
	elif mousePos.y > self.global_position.y - launcher.shootLeeway:
		self.modulate = Color(1.0, 0.5, 0.5)
		self.visible = true
	else:
		self.modulate = Color(1.0, 1.0, 1.0)
		self.visible = true
	dir = (mousePos - self.global_position).normalized()
	distance = mousePos.distance_to(self.global_position)
	for i in range(numChildren):
		var curChild = self.get_child(i)
		curChild.global_position = self.global_position + (dir * ((i+1)*distance)/numChildren)
		

func _input(event):
	if event is InputEventMouse:
		mousePos = event.position