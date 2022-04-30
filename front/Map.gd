extends YSort
onready var Grass = preload("GrassBlock.tscn")
onready var Road = preload("RoadBlock.tscn")
onready var CrossRoad = preload("CrossRoadBlock.tscn")


func _ready():
	set_block()


var BLOCK_SIZE = 512 / 4
var SIZE = 8

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
		return CrossRoad.instance()
	if (x == ((SIZE - 1) / 2)):
		var road = Road.instance()
		road.rotate(PI / 2)
		road.translate(Vector2.RIGHT * BLOCK_SIZE)
		return road
	if (y == (SIZE / 2)):
		return Road.instance()
	return Grass.instance()
