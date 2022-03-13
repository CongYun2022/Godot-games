extends Control


onready var file = $Express/Menus/File
onready var help = $Express/Menus/Help

onready var editor = $Express/Editor
onready var down = $Express/DownBar/Position

onready var open = $Popups/Open
onready var save = $Popups/Save
onready var welcome = $Popups/Welcome


func _ready():
	file.get_popup().connect("id_pressed", self, "_file_id_pressed")
	help.get_popup().connect("id_pressed", self, "_help_id_pressed")


func _file_id_pressed(id):
	if id == 0:
		open.popup()
	elif id == 1:
		save.popup()
	elif id == 2:
		get_tree().quit()
	else:
		print("Error ID!" + id)

func _help_id_pressed(id):
	if id == 0:
		welcome.popup()


func _on_Open_file_selected(path):
# warning-ignore:shadowed_variable
	var file = File.new()
	file.open(path, File.READ_WRITE)
	editor.text = file.get_as_text()
	
	file.close()


func _on_Save_file_selected(path):
# warning-ignore:shadowed_variable
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_string(editor.text)
	
	file.close()


func _on_Editer_cursor_changed():
	var cu_l = editor.cursor_get_line()
	var cu_c = editor.cursor_get_column()
	
	var text = "( " + str(cu_l) + ", " + str(cu_c) + " )"
	down.text = text


