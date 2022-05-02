extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# export ()

const ACCELERATION = 500*24/2
const MAX_SPEED = 1200*2

onready var blue = $BlueCar
onready var green = $GreenCar
onready var red = $RedCar

var SPEED_CONST = 2.5

var rng = RandomNumberGenerator.new()
var direction: Vector2
var velocity = Vector2.ZERO
enum COLOR {
	Green, Red, Blue
}
var color = null

var time_start = 0
var time_now = 0

func _ready():
	rng.randomize()
	var random = rng.randf_range(0, 3)
	var rndNumber = int(random) % 3
	match int(random):
		0: 
			blue.show()
		1: 
			green.show()
		2: 
			red.show()
	color = rndNumber
	
	time_start = OS.get_unix_time()
	set_process(true)


func _process(delta):
	time_now = OS.get_unix_time()
	var elapsed = time_now - time_start
	var seconds = elapsed % 60
	
	if (seconds == 15):
		get_parent().remove_child(self)
	
func set_up():
	velocity = Vector2.UP
	rotate(- get_rotation())

func set_down():
	velocity = Vector2.DOWN
	rotate(PI - rotation)

func set_left():
	velocity = Vector2.LEFT
	rotate(3 * PI / 2 - rotation)

func set_right():
	velocity = Vector2.RIGHT
	rotate(PI / 2 - rotation)

func set_position(vec: Vector2):
	position.x = vec.x
	position.y = vec.y
	
func _physics_process(delta):
	position += velocity * SPEED_CONST

