class_name RoomsManager25D extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Gets the room based on the room name
func get_room_from_name(room_name) -> Room25D:
	return get_child(0)
