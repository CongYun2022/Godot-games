extends Camera2D


onready var player = get_node("../Player")


# tracks the player along the X axis
func _process (_delta):
	position.x = player.position.x
