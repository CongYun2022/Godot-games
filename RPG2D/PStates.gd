extends Control

onready var levelText : Label = $BG/VBoxContainer/HBoxContainer/LevelText
onready var healthBar : TextureProgress = $BG/VBoxContainer/HBoxContainer/VBoxContainer/HealthBar
onready var xpBar : TextureProgress = $BG/VBoxContainer/HBoxContainer/VBoxContainer/XPBar
onready var goldText : Label = $BG/VBoxContainer/GoldText


func _ready():
	levelText.text = "0"
	healthBar.value = 100
	xpBar.value = 0
	goldText.text = "Gold: " + "0"
	

# updates the level text Label node
func update_level_text(level):
	levelText.text = str(level)
 
# updates the health bar TextureProgress value
func update_health_bar(curHp, maxHp):
	healthBar.value = (100 / maxHp) * curHp
 
# updates the xp bar TextureProgress value
func update_xp_bar(curXp, xpToNextLevel):
	xpBar.value = (100 / xpToNextLevel) * curXp
 
# updates the gold text Label node
func update_gold_text(gold):
	goldText.text = "Gold: " + str(gold)

