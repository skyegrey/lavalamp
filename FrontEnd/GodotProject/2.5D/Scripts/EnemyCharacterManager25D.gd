class_name EnemyCharacterManager25D extends CharacterManager25D

var enemy_list: Array[EnemyCharacterResource]
var enemy_marker

# Scene refs
@onready var enemy_scene = load("res://2.5D/Scenes/enemy_character25D.tscn")

# State varibales
var enemy_characters: Array[EnemyCharacter25D]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

## Spwans a new enemy from the list of possible enemies for a given room
func spawn_new_enemy():
	# Determine random enemy spawn
	var enemy_resource = _determine_enemy_spawn()
	
	# Create new enemy
	var new_enemy = enemy_scene.instantiate()
	
	# Set stats resource
	new_enemy.set_stats(enemy_resource.stats)
	
	# Set sprite bounding box
	new_enemy.set_sprite_bounding_box(enemy_resource.sprite_bounding_box)
	
	# Add to enemies
	add_child(new_enemy)
	
	# Set enemy sprite
	new_enemy.set_sprite_frames(enemy_resource.sprite_frames)
	
	# Set the name
	new_enemy.set_character_name(enemy_resource.name)
	
	# Set the position of the enemy to be the position of the room
	new_enemy.position = enemy_marker.position
	
	enemy_characters.append(new_enemy)

## Randomly selects an enemy to spwan from the list of possible enemies
func _determine_enemy_spawn() -> EnemyCharacterResource:
	return enemy_list.pick_random()

## Sets the rooms enemy list to spawn from
func set_enemy_list(_enemy_list):
	enemy_list = _enemy_list
