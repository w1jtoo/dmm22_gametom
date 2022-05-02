extends HTTPRequest
const Car = preload("Car.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


#func _ready():
#	var http_request = HTTPRequest.new()
#	add_child(http_request)
#	http_request.connect("request_completed", self, "_http_request_completed")
#
#	# Perform the HTTP request. The URL below returns a PNG image as of writing.
#	var error = http_request.request("http://37.79.216.231:8000/lol.json")
#	if error != OK:
#		push_error("Что-то поломалось")
#
#
## Called when the HTTP request is completed.
## func _http_request_completed(result, response_code, headers, body):
#func _http_request_completed(result, response_code, headers, body):
#	var response = parse_json(body.get_string_from_utf8())
#	var cars = response.cars
#	for carData in cars:
#		var car = Car.instance()
#		car.position.x = carData.position.x
#		car.position.y = carData.position.y
#		if carData.direction == 0:
#			car.direction = Vector2.UP
#		if carData.direction == 1:
#			car.direction = Vector2.RIGHT
#		if carData.direction == 2:
#			car.direction = Vector2.DOWN
#		if carData.direction == 3:
#			car.direction = Vector2.LEFT
#
#		add_child(car)
