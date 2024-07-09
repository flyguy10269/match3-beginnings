extends Node2D

@onready var new_game_scene = "res://scenes/combat.tscn";
#@export var new_game_scene : PackedScene;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_new_game_button_up():
	get_tree().change_scene_to_file(new_game_scene);


func _on_settings_button_up():
	pass # Replace with function body.
