extends TextEdit


func _ready():
	draw_minimap(true)
	
	# keywords
	add_keyword_color("fun", Color( 0.39, 0.58, 0.93, 1 ))
	add_keyword_color("var", Color( 0.39, 0.58, 0.93, 1 ))
	add_keyword_color("if", Color( 0.39, 0.58, 0.93, 1 ))
	add_keyword_color("else", Color( 0.39, 0.58, 0.93, 1 ))
	add_keyword_color("while", Color( 0.39, 0.58, 0.93, 1 ))
	
	# String
	add_color_region("\"", "\"", Color( 1, 0.84, 0, 1 ))
	
	# commit
	add_color_region("#*", "*#", Color( 0.33, 0.42, 0.18, 1 ))
	
	# Number
	for i in range(0, 10):
		for j in range(0, 10):
			add_color_region(str(i), str(j), Color( 0.2, 0.8, 0.2, 1 ))
