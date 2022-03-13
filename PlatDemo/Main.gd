extends Node2D


onready var score_show = $UI/ScoreBar


func _on_Player_score_change(new):
	score_show.set_score_text(new)
