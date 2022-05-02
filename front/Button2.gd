extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _ready():
	self.connect("pressed", self, "_button_pressed")



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _button_pressed():
	get_tree().change_scene("res://Game.tscn")
