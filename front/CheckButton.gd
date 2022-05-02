extends Button

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var state = 0 # 0 up, 1 right, 2 down
# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("pressed", self, "_button_pressed")



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _button_pressed():
	state = (state + 1) % 3
	
func _process(delta):
	if state == 0:
		self.modulate = Color.blue
		self.text = "UP"
	elif state == 1:
		self.modulate = Color.green
		self.text = "RIGHT"
	else:
		self.modulate = Color.red
		self.text = "DOWN"
