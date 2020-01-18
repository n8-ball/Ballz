extends Sprite

var launcher
var visibleDelay = false

# Called when the node enters the scene tree for the first time.
func _ready():
	launcher = self.get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if launcher.state == launcher.HOLD_STATE or launcher.state == launcher.SHOOT_STATE:
		if visibleDelay == false:
			self.visible = true
		visibleDelay = false
	else:
		self.visible = false
		visibleDelay = true
