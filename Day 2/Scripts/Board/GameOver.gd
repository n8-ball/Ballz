extends Area2D

var game

# Called when the node enters the scene tree for the first time.
func _ready():
	game = self.get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var bodies = self.get_overlapping_bodies()
	if len(bodies) > 0:
		game.end_game()
