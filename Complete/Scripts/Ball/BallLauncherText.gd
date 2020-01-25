extends RichTextLabel

var launcher

# Called when the node enters the scene tree for the first time.
func _ready():
	launcher = self.get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if launcher.ammo > 0:
		self.visible = true
		self.set_bbcode("[center]" + "x" + str(launcher.ammo) + "[/center]")
	else:
		self.visible = false
