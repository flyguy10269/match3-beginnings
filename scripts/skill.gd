extends Control

@export var button_icon : Resource;
@export var min_button_size : int;
@export var details : String;

@onready var button = $Button;

# Called when the node enters the scene tree for the first time.
func _ready():
	#var button = Button.new();
	button.text = details;
	button.pressed.connect(self._button_pressed);
	button.icon = button_icon;
	button.custom_minimum_size.y = min_button_size;
	add_child(button);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _button_pressed():
	print("Hello");
