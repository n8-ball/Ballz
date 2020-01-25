extends Button

var menu
var game = "res://Scenes/Board/Game.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	menu = self.get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.pressed:
		get_tree().change_scene(game)
		menu.get_parent().remove_child(menu)
