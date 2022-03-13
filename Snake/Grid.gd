extends TileMap

class_name Grid


export var line_color: Color = Color( 0, 0.75, 1, 1 )
export var line_thickness: int = 1

onready var half_cell_size = get_cell_size() / 2

onready var grid_size = Vector2(32, 19)
var grid: Array


func _ready():
	init_grid()
	_draw()


func init_grid():
	grid = []
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(null)


func _draw():
	for x in range(grid_size.x):
		var start_point: Vector2 = Vector2(x * cell_size.x , 0)
		var end_point: Vector2 = Vector2(x * cell_size.x, 
										 grid_size.y * cell_size.y)
		draw_line(start_point, end_point, line_color, line_thickness)
		
	for y in range(grid_size.y):
		var start_point: Vector2 = Vector2(0, y * cell_size.y)
		var end_point: Vector2 = Vector2(grid_size.x * cell_size.x, 
										 y * cell_size.y)
		draw_line(start_point, end_point, line_color, line_thickness)


func place_entity_at_random_pos(entity: Node2D):
	var has_random_pos: bool = false
	var random_grid_pos: Vector2
	
	while has_random_pos == false:
		var temp_pos: Vector2 = Vector2(randi() % int(grid_size.x), 
										randi() % int(grid_size.y))
		if get_entity_of_cell(temp_pos) == null:
			random_grid_pos = temp_pos
			has_random_pos = true
			
	place_entity(entity, random_grid_pos)


func get_entity_of_cell(grid_pos: Vector2):
	return grid[grid_pos.x][grid_pos.y] as Node2D

func place_entity(entity: Node2D, grid_pos: Vector2):
	set_entity_in_cell(entity, grid_pos)
	# enity 锚点于中央
	entity.set_position(map_to_world(grid_pos) + half_cell_size)

func set_entity_in_cell(entity: Node2D, grid_pos: Vector2):
	grid[grid_pos.x][grid_pos.y] = entity


