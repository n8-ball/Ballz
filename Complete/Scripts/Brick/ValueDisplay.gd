extends RichTextLabel

var brick

# Called when the node enters the scene tree for the first time.
func _ready():
	brick = self.get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.set_bbcode("[center]" + str(brick.value) + "[/center]")
