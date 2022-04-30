extends HTTPRequest
const Car = preload("Car.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():
	_http_request_completed()
	#var http_request = HTTPRequest.new()
	#add_child(http_request)
	#http_request.get("request_completed", self, "_http_request_completed")

	# Perform the HTTP request. The URL below returns a PNG image as of writing.
	#var error = http_request.request("https://via.placeholder.com/512")
	#if error != OK:
	#	push_error("Что-то поломалось")


# Called when the HTTP request is completed.
# func _http_request_completed(result, response_code, headers, body):
func _http_request_completed():
	var car = Car.instance()
	car.position.x = 0
	car.position.y = 0
	add_child(car)
