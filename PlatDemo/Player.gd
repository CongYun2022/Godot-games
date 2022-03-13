extends KinematicBody2D


signal score_change(new)


# stats
var score : int = 0
 
# physics
var speed : int = 200
var jumpForce : int = 600
var gravity : int = 800
 
var vel : Vector2 = Vector2()
var grounded : bool = false

# components
onready var sprite = $Sprite


func _physics_process (delta):
	# reset horizontal velocity
	vel.x = 0

	# movement inputs 
	# press -> ac?
	if Input.is_action_pressed("move_left"):
		vel.x -= speed
	if Input.is_action_pressed("move_right"):
		vel.x += speed
		
	# applying the velocity
	vel = move_and_slide(vel, Vector2.UP)
	# gravity
	vel.y += gravity * delta
	 
	# jump input
	if Input.is_action_pressed("jump") and is_on_floor():
		vel.y -= jumpForce
	
	# sprite direction
	if vel.x < 0:
		sprite.flip_h = true
	elif vel.x > 0:
		sprite.flip_h = false


# called when we hit an enemy
func die():
	get_tree().reload_current_scene()
	

# called when we run into a coin
func collect_coin(value):
	score += value
	emit_signal("score_change", score)
