extends KinematicBody2D

var _timer = null
var counter = 0

func _ready():
	_timer = Timer.new()
	add_child(_timer)

	_timer.connect("timeout", self, "_on_Timer_timeout")
	_timer.set_wait_time(1.0)
	_timer.set_one_shot(false) # Make sure it loops
	_timer.start()


func _on_Timer_timeout():
	if counter % 2 == 0:
		position += Vector2.UP * 10
	else:
		position += Vector2.DOWN * 10

	counter += 1

