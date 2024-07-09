extends Node

var equipment = [null,null,null,null,null,null];

func set_equipment(item):
	match item.type:
		"weapon":
			equipment[0] = item;
		"offhand":
			equipment[1] = item;
		"chest":
			equipment[2] = item;
		"boots":
			equipment[3] = item;
		"gloves":
			equipment[4] = item;
		"helmet":
			equipment[5] = item;
		"pants":
			equipment[6] = item;
		_:
			print("not equippable");
		
#	if item.item_type == "weapon":
#		equipment[0] = item;
#	elif item.item_type == "offhand":
#		equipment[1] = item;
