class_name CharacterManager25D extends Node

# Node refs
@onready var rooms_manager = %RoomsManager

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
## Joins a character to a room
# Changes character position based on room position & characters in the room
func _join_room(character, room_name):
	# Fetch the room
	var room := _get_room_reference(room_name)
	
	# Add the character to the current room
	room.add_character(character)

## Gets a room reference based on the room name
func _get_room_reference(room_name) -> Room25D:
	return rooms_manager.get_room_from_name(room_name)
