extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# export ()
onready var texture = $TextureRect

func _ready():
	rotate(Vector2.UP.angle())
	position.x = 0
	position.y = 0


func _process(delta):
	pass 
	
func _physics_process(delta):
	position.x += 10

