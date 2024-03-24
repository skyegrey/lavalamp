extends Camera3D

@export var RUMBLE_MAGNITUDE: float = 0.05
@export var RUMBLE_SPEED: float = 1

# Origin to rumble around
var base_position: Vector3

# Time variable
var time: float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	base_position = position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Add delta to time
	time += delta * RUMBLE_SPEED
	
	# This is just to try and prevent an overflow
	if time >= 100:
		time -= 100
	
	
	position.x = base_position.x + (sin(time * 0.8) * 1.5 * RUMBLE_MAGNITUDE)
	position.y = base_position.y + (cos(time * 1.2) * RUMBLE_MAGNITUDE)
	pass
