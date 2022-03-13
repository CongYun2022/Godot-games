extends Node2D


const scene_snake = preload("res://Snake.tscn")
const scene_food = preload("res://Food.tscn")

onready var grid: Grid = get_node("Grid")

var snake: Area2D


func _ready():
	randomize()
	init_entities()


func init_entities():
	snake = scene_snake.instance() as Area2D
	add_child(snake)
	grid.place_entity_at_random_pos(snake)




