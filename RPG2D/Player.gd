extends KinematicBody2D


var gold : int = 0

onready var rayCast = $Ray
onready var anim = $AnSprite
onready var con = get_node("/root/Main")

var curHp : int = 10
var maxHp : int = 10
var moveSpeed : int = 250
var damage : int = 1
 
var curLevel : int = 0
var curXp : int = 0
var xpToNextLevel : int = 50
var xpToLevelIncreaseRate : float = 1.2
 
var interactDist : int = 70
 
var vel = Vector2()
var facingDir = Vector2()


func _ready():
	pass
 

func _physics_process(_delta):
	vel = Vector2()
 
	# inputs
	if Input.is_action_pressed("move_up"):
		vel.y -= 1
		facingDir = Vector2(0, -1)
	if Input.is_action_pressed("move_down"):
		vel.y += 1
		facingDir = Vector2(0, 1)
	if Input.is_action_pressed("move_left"):
		vel.x -= 1
		facingDir = Vector2(-1, 0)
	if Input.is_action_pressed("move_right"):
		vel.x += 1
		facingDir = Vector2(1, 0)
	if Input.is_action_just_pressed("interact"):
		try_interact()
 
	# normalize the velocity to prevent faster diagonal movement
	vel = vel.normalized()
	# move the player
	# warning-ignore:return_value_discarded
	move_and_slide(vel * moveSpeed, Vector2.ZERO)
	
	manage_animations()


func manage_animations():
	if vel.x > 0:
		play_animation("MoveRight")
	elif vel.x < 0:
		play_animation("MoveLeft")
	elif vel.y < 0:
		play_animation("MoveUp")
	elif vel.y > 0:
		play_animation("MoveDown")
	elif facingDir.x == 1:
		play_animation("IdleRight")
	elif facingDir.x == -1:
		play_animation("IdleLeft")
	elif facingDir.y == -1:
		play_animation("IdleUp")
	elif facingDir.y == 1:
		play_animation("IdleDown")


func play_animation(anim_name):
	if anim.animation != anim_name:
		anim.play(anim_name)



func try_interact ():
	rayCast.cast_to = facingDir * interactDist
 
	if rayCast.is_colliding():
		if rayCast.get_collider() is KinematicBody2D:
			rayCast.get_collider().take_damage(damage)
		elif rayCast.get_collider().has_method("on_interact"):
			rayCast.get_collider().on_interact(self)


func give_gold(amount):
	gold += amount
	con.p_gold_change(gold)

func give_xp(amount):
	curXp += amount
	if curXp >= xpToNextLevel:
		level_up()
	
	con.p_xp_change(curXp, xpToNextLevel)
 
func level_up():
	var overflowXp = curXp - xpToNextLevel
	xpToNextLevel *= xpToLevelIncreaseRate
	curXp = overflowXp
	curLevel += 1

	con.p_level_up(curLevel, curXp, xpToNextLevel)

func take_damage(dmgToTake):
	curHp -= dmgToTake
	if curHp <= 0:
		die()
		
	con.p_get_damage(curHp, maxHp)
 
func die():
	get_tree().reload_current_scene()



func _on_InitTimer_timeout():
	con.p_level_set(curLevel)
	con.p_health_change(curHp, maxHp)
	con.p_xp_change(curXp, xpToNextLevel)
	con.p_gold_change(gold)
