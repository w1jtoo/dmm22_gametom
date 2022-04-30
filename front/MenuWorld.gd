extends Node2D
const Car = preload("Car.tscn")
onready var RoadMap = $Road
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
var cars = []
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	var car = Car.instance()
	cars.append(car)
	RoadMap.add_child(car)
	var start = rng.randf_range(100, 200)
	car.position.x -= start
	car.position.y -= 100
	car.blue.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var start = rng.randf_range(0, 2000)
	var end = 1000
	for car in cars:
		if car.position.x > end:
			car.position.x -= start + end
			car.blue.hide()
			car.red.hide()
			car.green.hide()
			match int(start) % 3:
				0: car.blue.show()
				1: car.green.show()
				2: car.red.show()
			continue
		car.position.x += 10
		
