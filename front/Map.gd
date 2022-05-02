extends YSort
onready var Grass = preload("GrassBlock.tscn")
onready var Road = preload("RoadBlock.tscn")
onready var CrossRoad = preload("CrossRoadBlock.tscn")
onready var Car = preload("Car.tscn")
onready var Arrow = preload("Arrow.tscn")
onready var Lights = preload("Lights.tscn")

onready var PushUps = preload("PushUp.tscn")


var cars = []
var light = null
var proccessed_cars = []
var score = 0

func _ready():
	_timer = Timer.new()
	add_child(_timer)

	_timer.connect("timeout", self, "_on_Timer_timeout")
	_timer.set_wait_time(1.0)
	_timer.set_one_shot(false) # Make sure it loops
	_timer.start()
	
	set_block()
	spawn_car()

func spawn_car():
	var newCar = Car.instance()
	newCar.set_right()
	newCar.set_position(Vector2(0, BLOCK_SIZE * SIZE / 2 - BLOCK_SIZE * 3 / 4))
	cars.append(newCar)
	
	newCar.SPEED_CONST = speed
	add_child(newCar)

var BLOCK_SIZE = 512 / 4
var SIZE = 8

# Vector2(BLOCK_SIZE * SIZE / 2, 0), Vector2(0, BLOCK_SIZE * SIZE / 2 - BLOCK_SIZE * 3 / 4)]

var down_arrow:Node2D = null
var up_arrow:Node2D = null
var right_arrow:Node2D = null

func load_down_arrows(vec: Vector2):
	var arrow = Arrow.instance()
	arrow.position = vec
	arrow.modulate = Color.red
	arrow.rotate(-PI/2)
	down_arrow = arrow
	add_child(arrow)

func load_up_arrows(vec: Vector2):
	var arrow = Arrow.instance()
	arrow.modulate = Color.blue
	arrow.position = vec
	arrow.rotate(PI/2)
	up_arrow = arrow
	add_child(arrow)
	
func load_right_arrows(vec: Vector2):
	var arrow = Arrow.instance()
	arrow.modulate = Color.green
	arrow.position = vec
	arrow.rotate(PI)
	right_arrow = arrow
	add_child(arrow)

func set_block():
	var xPos = 64
	var yPos = 64
	var oldRect = null

	for i in range(SIZE):
		for j in range(SIZE):
			var block = generate_insance(i, j)
			
			block.position.x = xPos
			block.position.y = yPos

			add_child(block)
			xPos += BLOCK_SIZE
		yPos += BLOCK_SIZE
		xPos = 64


func generate_insance(x: int, y: int) -> Node:
	if (y == (SIZE / 2) and x == (SIZE - 1)/ 2):
		light = Lights.instance()
		# light.position.x = SIZE * BLOCK_SIZE / 2
		# light.position.y = SIZE * BLOCK_SIZE / 2
		add_child(light)
		return CrossRoad.instance()

	if (x == ((SIZE - 1) / 2)):
		var road = Road.instance()
		road.rotate(PI / 2)
		road.translate(Vector2.RIGHT * BLOCK_SIZE)

		return road
	if (y == (SIZE / 2)):
		return Road.instance()
	return Grass.instance()

var time = 0
func update_arrow():
	var state = light.get_node("CheckButton").state
	var default_scale = Vector2.ONE * 0.25
	
	up_arrow.set_scale(default_scale)
	right_arrow.set_scale(default_scale)
	down_arrow.set_scale(default_scale)

	var result = default_scale * (abs(sin(time / 100)) / 3 + 1)
	if state == 0:
		up_arrow.set_scale(result)
	elif state == 1:
		right_arrow.set_scale(result)
	else:
		down_arrow.set_scale(result)
	
	time += 10

func _process(delta):
	var text = get_node("Node2D/TextEdit")
	text.text = "%d:%02d" % [floor($Timer.time_left / 60), int($Timer.time_left) % 60]
	
	
	load_up_arrows(Vector2(3.5 * BLOCK_SIZE, 2.5 * BLOCK_SIZE))
	load_down_arrows(Vector2(3.5 * BLOCK_SIZE, 4.5 * BLOCK_SIZE))
	load_right_arrows(Vector2(5.5 * BLOCK_SIZE, 2.5 * BLOCK_SIZE))
	
	update_arrow()
	
	
	print(score)
	var center = (SIZE + 1) / 2 * BLOCK_SIZE + BLOCK_SIZE / 4
	var newCars = []
	for car in cars:
		if center - car.position.x < 0:
			if light.get_node("CheckButton").state == 0:
				car.set_up()
			elif light.get_node("CheckButton").state == 1:
				car.set_right()
			else:
				car.set_down()
			proccessed_cars.append(car)
		else:
			newCars.append(car)
	cars = newCars
	
	var resultProccesCars = []
	for car in proccessed_cars:
		if (car.position.y <= 0):
			if car.color == 0: # blue
				score += 1
				if score % 2 == 0:
					game_speed_up()
			else:
				score -= 1
		elif (car.position.y >= BLOCK_SIZE * SIZE):
			if car.color == 2: # green
				score += 1
				if score % 2 == 0:
					game_speed_up()
			else:
				score -= 1
		elif car.position.x >= BLOCK_SIZE * SIZE:
			if car.color == 1: # red
				score += 1
				if score % 2 == 0:
					game_speed_up()
			else:
				score -= 1
		else:
			resultProccesCars.append(car)
	
	proccessed_cars = resultProccesCars
	
	var text = get_node("Node2D/RichTextLabel")
	text.text = "UR SCOPE IS: " + str(score)
	
	if score < -10:
		game_over()

func spawn_push_up():
	var pushUp = PushUps.instance();
	add_child(pushUp)

func _input(event):
	if event.is_action_pressed("ui_up"):
		light.get_node("CheckButton").state = 0
	elif event.is_action_pressed("ui_right"):
		light.get_node("CheckButton").state = 1
	elif event.is_action_pressed("ui_down"):
		light.get_node("CheckButton").state = 2

var speed = 2.5

func game_speed_up():
	spawn_push_up()
	var time_speed_up = 1.08
	speed *= time_speed_up
	for car in cars:
		car.SPEED_CONST = speed
	for car in proccessed_cars:
		car.SPEED_CONST = speed
	
	
var _timer = null
var counter = 0

func game_over():
	get_tree().change_scene("res://GameOver.tscn")

func _on_Timer_timeout():
	spawn_car()
