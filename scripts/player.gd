extends Node2D

#starting values remove gold export later
@export var gold: int;
@export var starting_health: int;
var weapon_points = 0;
var shield_points = 0;
var mana_points = 0;

@export var inventory = [];

enum equipped  {
	weapon,
	offhand,
	helmet,
	gloves,
	chest,
	legs,
	feet,
	};
func set_equipment():
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
