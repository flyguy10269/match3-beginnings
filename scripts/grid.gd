extends Node2D
#state machine
enum {wait, move};
var state;

#grid variables 
@export var width : int;
@export var height : int;
@export var x_start : int;
@export var y_start : int;
@export var offset : int;
@export var y_offset : int;
#future scaling
#var x_start : DisplayServer.window_get_size().x;
#var y_start : DisplayServer.window_get_size().y;

#swap back 
var tile_one = null;
var tile_two = null;
var last_place = Vector2(0,0);
var last_direction = Vector2(0,0);
var move_checked = false;

#array of tiles
var possible_tiles = [
	
	preload("res://scenes/pieces/blue_potion_piece.tscn"),
	preload("res://scenes/pieces/bread_piece.tscn"),
	#preload("res://scenes/pieces/coal_piece.tscn"),
	#preload("res://scenes/pieces/copper_piece.tscn"),
	preload("res://scenes/pieces/empty_bottle_piece.tscn"),
	preload("res://scenes/pieces/fabric_piece.tscn"),
	#preload("res://scenes/pieces/knife_piece.tscn"),
	preload("res://scenes/pieces/leather_piece.tscn"),
	preload("res://scenes/pieces/log_piece.tscn"),
	preload("res://scenes/pieces/red_potion_piece.tscn"),
	preload("res://scenes/pieces/string_piece.tscn"),
	#preload("res://scenes/pieces/wooden_shield_piece.tscn"),
	#preload("res://scenes/pieces/wooden_staff_piece.tscn"),
	
];
#array for grid
var all_tiles = [];

#touch variables
var first_touch = Vector2(0,0);
var release_touch = Vector2(0,0);
var controlling = false;

func make_2d_array():
	var array = [];
	for i in width:
		array.append([]);
		for j in height:
			array[i].append(null);
	return array;

func grid_to_pixel(column, row):
	var new_x = x_start + offset * column;
	var new_y = y_start + -offset * row;
	return Vector2(new_x, new_y);

func pixel_to_grid(pixel_x, pixel_y):
	var new_x = round((pixel_x - x_start) / offset);
	var new_y = round((pixel_y - y_start) / -offset);
	return Vector2(new_x, new_y);

func is_in_grid(grid_position):
	if grid_position.x >= 0 && grid_position.x < width:
		if grid_position.y >=0 && grid_position.y < height: 
			return true;
	else:
		return false;

func touch_input():
	if Input.is_action_just_pressed("ui_touch"):
		if is_in_grid(pixel_to_grid(get_global_mouse_position().x,get_global_mouse_position().y)):
			first_touch = pixel_to_grid(get_global_mouse_position().x, get_global_mouse_position().y);
			controlling = true;

	if Input.is_action_just_released("ui_touch"):
		if is_in_grid(pixel_to_grid(get_global_mouse_position().x, get_global_mouse_position().y)) && controlling:
			controlling = false;
			release_touch = pixel_to_grid(get_global_mouse_position().x, get_global_mouse_position().y);
			touch_difference(first_touch, release_touch);

func swap_tiles(column, row, direction):
	var first_tile = all_tiles[column][row];
	var other_tile = all_tiles[column + direction.x][row + direction.y];
	if first_tile != null && other_tile != null:
		
		store_info(first_tile, other_tile, Vector2(column, row), direction);
		
		#wait to move again
		state = wait;
		
		all_tiles[column][row] = other_tile;
		all_tiles[column + direction.x][row + direction.y] = first_tile;
		first_tile.move(grid_to_pixel(column + direction.x, row + direction.y));
		other_tile.move(grid_to_pixel(column, row));
		if !move_checked:
			find_matches();

func store_info(first_tile, other_tile, place, direction):
	tile_one = first_tile;
	tile_two = other_tile;
	last_place = place;
	last_direction = direction;

func swap_back():
	#move tiles back to where they were
	if tile_one != null && tile_two != null:
		swap_tiles(last_place.x,last_place.y, last_direction);
	state = move;
	move_checked = false;

func touch_difference(grid_1, grid_2):
	var difference = grid_2 - grid_1;
	if abs(difference.x) > abs(difference.y):
		if difference.x > 0:
			swap_tiles(grid_1.x, grid_1.y, Vector2(1,0));
		elif difference.x < 0:
			swap_tiles(grid_1.x, grid_1.y, Vector2(-1,0));
	elif abs(difference.y) > abs(difference.x):
		if difference.y > 0:
			swap_tiles(grid_1.x, grid_1.y, Vector2(0,1));
		elif difference.y < 0:
			swap_tiles(grid_1.x, grid_1.y, Vector2(0,-1));

func spawn_tiles():
	for i in width:
		for j in height:
			var rand = floor(randf_range(0, possible_tiles.size()));
			var tile = possible_tiles[rand].instantiate();
			var loops = 0;
			while(match_at(i, j, tile.type) && loops < 100):
				rand = floor(randf_range(0, possible_tiles.size()));
				loops =+ 1;
				tile = possible_tiles[rand].instantiate()
			add_child(tile);
			tile.position = grid_to_pixel(i, j);
			all_tiles[i][j] = tile;

func match_at(i, j, type):
	if i > 1:
		if all_tiles[i-1][j] != null && all_tiles[i-2][j] != null:
			if all_tiles[i-1][j].type == type && all_tiles[i-2][j].type == type:
				return true;
	if j > 1: 
		if all_tiles[i][j-1] != null && all_tiles[i][j-2] != null:
			if all_tiles[i][j-1].type == type && all_tiles[i][j-2].type == type:
				return true;

func find_matches():
	for i in width:
		for j in height:
			if all_tiles[i][j] != null:
				var current_type = all_tiles[i][j].type;
				if i > 0 && i < width - 1:
					if all_tiles[i-1][j] != null && all_tiles[i+1][j] != null:
						if all_tiles[i-1][j].type == current_type && all_tiles[i+1][j].type == current_type:
							all_tiles[i][j].matched = true;
							all_tiles[i][j].dim();
							all_tiles[i-1][j].matched = true;
							all_tiles[i-1][j].dim();
							all_tiles[i+1][j].matched = true;
							all_tiles[i+1][j].dim();
				if j > 0 && j < height - 1:
					if all_tiles[i][j-1] != null && all_tiles[i][j+1] != null:
						if all_tiles[i][j-1].type == current_type && all_tiles[i][j+1].type == current_type:
							all_tiles[i][j].matched = true;
							all_tiles[i][j].dim();
							all_tiles[i][j-1].matched = true;
							all_tiles[i][j-1].dim();
							all_tiles[i][j+1].matched = true;
							all_tiles[i][j+1].dim();
	get_parent().get_node("destroy_timer").start();

func _ready():
	state = move;
	all_tiles = make_2d_array();
	spawn_tiles();

func _process(delta):
	#wait for movement before allowing to click again
	if state == move:
		touch_input();

func destroy_matched():
	var was_matched = false;
	for i in width:
		for j in height:
			if all_tiles[i][j] != null:
				if all_tiles[i][j].matched:
					was_matched = true;
					all_tiles[i][j].queue_free();
					all_tiles[i][j] = null;
	move_checked = true;
	if was_matched:
		get_parent().get_node("collapse_timer").start();
	else:
		swap_back();

func collapse_collumns():
	for i in width:
		for j in height:
			if all_tiles[i][j] == null:
				for k in range(j + 1, height):
					if all_tiles[i][k] != null:
						all_tiles[i][k].move(grid_to_pixel(i, j));
						all_tiles[i][j] = all_tiles[i][k];
						all_tiles[i][k] = null;
						break;
	get_parent().get_node("refill_timer").start();

func refill_collumns():
	for i in width:
		for j in height:
			if all_tiles[i][j] == null:
				var rand = floor(randf_range(0, possible_tiles.size()));
				var tile = possible_tiles[rand].instantiate();
				var loops = 0;
				while(match_at(i, j, tile.type) && loops < 100):
					rand = floor(randf_range(0, possible_tiles.size()));
					loops =+ 1;
					tile = possible_tiles[rand].instantiate()
				add_child(tile);
				tile.position = grid_to_pixel(i, j + y_offset);
				tile.move(grid_to_pixel(i, j));
				all_tiles[i][j] = tile;
	after_refill();

func after_refill():
	for i in width:
		for j in height:
			if all_tiles[i][j] != null:
				if match_at(i, j, all_tiles[i][j].type):
					find_matches();
					get_parent().get_node("destroy_timer").start();
					return;
	state = move;
	move_checked = false;

func _on_destroy_timer_timeout():
	destroy_matched();

func _on_collapse_timer_timeout():
	collapse_collumns();

func _on_refill_timer_timeout():
	refill_collumns();
