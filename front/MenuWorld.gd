extends Node2D
const Car = preload("Car.tscn")
onready var RoadMap = $Road
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
var cars = []

func _ready():
	var car = Car.instance()
	cars.append(car)
	RoadMap.add_child(car)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	for car in cars:
		car.position.x += 10
		
