extends Camera2D


onready var target = get_node("/root/Main/Player")


func _process (_delta):
	position = target.position
