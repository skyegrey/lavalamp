class_name PlayerCharacterManager25D extends CharacterManager25D

# Scene refs
var player_character_scene = preload("res://2.5D/Scenes/player_character25D.tscn")

# Resource refs
var new_character_stats = preload(
	"res://Resources/Saved/NewPlayerCharacterStats.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# Create perred, the first of many
	var perred := _create_character("perred")
	_join_room(perred, "Forest")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _create_character(twitch_username) -> Character25D:
	# Spawn in a new player
	var new_player = player_character_scene.instantiate()
	
	# Set the player name
	new_player.set_name(twitch_username)
	
	# Set the characters base stats
	new_player.set_stats(new_character_stats)
	
	# Set the player to not be visible before joining a room
	new_player.visible = false
	
	# Add child
	add_child(new_player)
	
	# Return the created character
	return new_player
