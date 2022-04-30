extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# export ()
onready var blue = $BlueCar
onready var green = $GreenCar
onready var red = $RedCar

var rng = RandomNumberGenerator.new()
var direction: Vector2

func _ready():
	rng.randomize()
	var random = rng.randf_range(0, 3)
	match int(random) % 3:
		0: blue.show()
		1: green.show()
		2: red.show()


func _process(delta):
	pass 
	
func _physics_process(delta):
	position += direction * 10

