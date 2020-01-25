extends AudioStreamPlayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	self.pitch_scale = rng.randf_range(1.8, 2.2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !self.playing:
		self.queue_free()
