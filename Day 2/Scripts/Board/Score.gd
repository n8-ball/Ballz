extends RichTextLabel

# Declare member variables here. Examples:
var game

# Called when the node enters the scene tree for the first time.
func _ready():
	game = self.get_parent().get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.set_bbcode("[center]" + str(game.score) + "[/center]")
