extends Node

@export_enum(
	"consumable", 
	"weapon", 
	"offhand", 
	"chest", 
	"boots", 
	"gloves", 
	"helmet", 
	"pants", 
	"material", 
) var item_type;
#values for equipment so the same script can be used for multiple things
#maybe hard code later to each individually who knows
#@export item_type;
@export var is_stackable: bool = true;
@export var attack: int = 0;
@export var attack_increase: int = 0;
@export var block: int = 0;
@export var defense: int = 0;
@export var dodge: int = 0;
@export var magic_attack: int = 0;
@export var magic_bonus: int = 0;
@export var health_increse: int = 0;
@export var healing_value: int = 0;
@export var mana_regeneration: int = 0;

##trying dictionary for item stats
func store_item_stats():
	var item_stats = {
		"ATCK" : attack,
		"ATCKBUFF" : attack_increase,
		"BLCK" : block,
		"DFNS": defense,
		"DODGE": dodge,
		"MGKATCK": magic_attack,
		"MGKBUFF": magic_bonus,
		"HLTHBUFF": health_increse,
		"STACKABLE": is_stackable,
		"HEAL_AMNT": healing_value,
		"MANAREG": mana_regeneration,
		
	}

# Called when the node enters the scene tree for the first time.
func _ready():
	store_item_stats();
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
