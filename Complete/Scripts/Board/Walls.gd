extends StaticBody2D

# Declare member variables here. Examples:
var sound = preload("res://Scenes/Board/BounceSound.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func hit(dir):
	self.add_child(sound.instance())
	return 0
