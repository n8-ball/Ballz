extends RichTextLabel

# Declare member variables here. Examples:
var colorArray = []
var numColors = 5

var colorTimer = 0
var colorTime = 0.08

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	for i in range(numColors):
		var newColor = Color(0, 255, 255)
		newColor.h = rng.randf_range(0, 1.0)
		newColor.s = 1.0
		newColor.v = 1.0
		colorArray.append(newColor)
	self.set_bbcode("[center] [color=#"+colorArray[0].to_html(false)+"]B[color=#"+colorArray[1].to_html(false)+"]a[color=#"\
	+colorArray[2].to_html(false)+"]l[color=#"+colorArray[3].to_html(false)+"]l[color=#"+colorArray[4].to_html(false)+"]z ")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	colorTimer += delta
	if colorTimer > colorTime:
		colorTimer = 0
		colorArray = []
		for i in range(numColors):
			var newColor = Color(0, 255, 255)
			newColor.h = rng.randf_range(0, 1.0)
			newColor.s = 1.0
			newColor.v = 1.0
			colorArray.append(newColor)
		self.set_bbcode("[center] [color=#"+colorArray[0].to_html(false)+"]B[color=#"+colorArray[1].to_html(false)+"]a[color=#"\
		+colorArray[2].to_html(false)+"]l[color=#"+colorArray[3].to_html(false)+"]l[color=#"+colorArray[4].to_html(false)+"]z ")
