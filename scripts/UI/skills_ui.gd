extends Control

var equipment = [
#	load("res://scenes/UI/skill_tags/wooden_shield.tscn"),
#	load("res://scenes/UI/skill_tags/wooden_staff.tscn"),
#	load("res://scenes/UI/skill_tags/wooden_sword.tscn"),
#	load("res://scenes/UI/skill_tags/knife.tscn"),
#	load("res://scenes/UI/skill_tags/red_potion.tscn"),
];


# Called when the node enters the scene tree for the first time.
func _ready():
	fill_skills();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func fill_skills():
	for i in equipment.size():
		var skill_container = $ScrollContainer/VBoxContainer;		
		skill_container.add_child(equipment[i].instantiate());
