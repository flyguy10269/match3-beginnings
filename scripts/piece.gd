extends Node2D

@export var type : String;
@export var base_value : int;

var matched = false;

func move(target):
	var tween:Tween = create_tween();
	tween.tween_property(self,"position",target, 0.3).set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT);

func dim():
	$Sprite.modulate.a = 0.5;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
