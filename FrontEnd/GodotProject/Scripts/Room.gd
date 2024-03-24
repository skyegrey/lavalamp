## A room for characters to join and fight monsters
class_name Room extends Node2D

# Children References
@onready var character_position_marker = $CharactersMarker
@onready var enemy_position_marker = $EnemyMarker
@onready var enemy_character_manager = $EnemyCharacterManager


# Room properties
@export var enemy_list: Array[EnemyCharacterResource]

# State vairables
var player_characters_in_room: Array[PlayerCharacter]

# Called when the node enters the scene tree for the first time.
func _ready():
	# Init Enemy Manager for the room
	_initialize_enemy_manager()
	enemy_character_manager.spawn_new_enemy()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Progress all players in the room forward on their attack timers
	_process_characters(delta)
	
	# Progress the enemy character forward on attack timers
	_process_enemy_characters(delta)
	pass

## Adds a character to the room
func add_character(character):
	# Move character into room control position
	character.global_position = _get_room_character_position()
	
	# Make character visible if room is visible
	character.visible = visible
	
	# Add the character to the list of characters in the room
	player_characters_in_room.append(character)
	
	# Attack to the signals of the character
	_connect_to_player_attack_signals(character)

## Determines the base position of the 
func _get_room_character_position() -> Vector2:
	var room_position = global_position
	var character_position = room_position + character_position_marker.global_position
	return character_position

## Initilizes the Enemy Manager
func _initialize_enemy_manager():
	# Set the list of enemies that can spawn
	enemy_character_manager.set_enemy_list(enemy_list)
	
	# Set the marker for the enemy spawn location
	enemy_character_manager.enemy_marker = enemy_position_marker

## Progress characters forward on their attack timers
func _process_characters(delta):
	for player_character in player_characters_in_room:
		player_character.progress_attack_timers(delta)

## Connects to the signal of attacking from the character
func _connect_to_player_attack_signals(character):
	character.attack.connect(_on_player_character_attack)

## Called when a player character makes an attack
# Attack the boss with the character
func _on_player_character_attack(character):
	pass

## Progress enemy characters forward on their attack timers
func _process_enemy_characters(delta):
	for enemy_character in enemy_character_manager.enemy_characters:
		enemy_character.progress_attack_timers(delta)
