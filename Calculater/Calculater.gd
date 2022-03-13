extends MarginContainer


onready var label = $Express/Result/Label

func _ready():
	for bu_li in $Express/ControlPanel/Numbers.get_children():
		for bu in bu_li.get_children():
			bu.connect("pressed", self, "_button_pressed", [bu.text])


func _button_pressed(text):
	if text == "C":
		label.text = ""
	elif text == "=":
		var res = _eval(label.text)
		if res is bool:
			label.text = "Error"
		else:
			label.text = str(res)		
	else:
		label.text += text
		

func _eval(text):
	var scr = GDScript.new()
	scr.set_source_code("tool\nfunc eval():\n\treturn ( " + text + ")")
	scr.reload()
	
	var obj = Reference.new()
	obj.set_script(scr)
	
	return obj.eval()




