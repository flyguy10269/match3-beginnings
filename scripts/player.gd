extends Node2D

#starting values remove gold export later
@export var gold: int;
@export var starting_health: int;
var weapon_points = 0;
var shield_points = 0;
var mana_points = 0;

@export var inventory = [];

var equipped
#set item to equipment slot
func set_equipment(item_type, item):
	if item_type == "weapon":
		equipped.weapon = item;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
