extends Node2D


onready var psta = $UI/PStates
onready var play = $Player


func _ready():
	pass


func p_gold_change(new):
	psta.update_gold_text(new)

func p_xp_change(new, nex):
	psta.update_xp_bar(new, nex)

func p_level_up(new, nex, ne_lev):
	psta.update_level_text(new)
	psta.update_xp_bar(nex, ne_lev)
	
func p_level_set(new):
	psta.update_level_text(new)

func p_get_damage(curHp, maxHp):
	psta.update_health_bar(curHp, maxHp)

func p_health_change(curHp, maxHp):
	psta.update_health_bar(curHp, maxHp)
