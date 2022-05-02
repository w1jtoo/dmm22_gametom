extends Node2D

onready var dog = $dog
onready var black = $black
onready var man = $man
onready var dick = $dick
# onready var red = $RedCar


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = Vector2.ONE * 2
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	var random = rng.randf_range(0, 2)
	position += Vector2.ONE * random
	
	random = int(rng.randf_range(0, 3))
	if random == 0:
		dog.show()
	elif random == 1:
		black.show()
	elif random == 2:
		dick.show()
	elif random == 3:
		man.show()
		
	var base_scale = 0.25
	random = int(rng.randf_range(0, 2))
	self.set_scale(Vector2.ONE * random)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += speed
	modulate.a8 -= 1
	
	if modulate.a8 == 0:
		get_parent().remove_child(self)
