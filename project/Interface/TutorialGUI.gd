extends CanvasLayer


var text_to_set = ""
var writing_text = false
var time_since_last_char_write = 0
var next_char = 0

const TIME_BETWEEN_CHAR_WRITES = 5

signal update_text(new_text)


#func _ready():
#	connect("update_text", self, "_update_text")


func _process(delta):
	if writing_text:
		if time_since_last_char_write >= TIME_BETWEEN_CHAR_WRITES:
			write_next_char()
			if next_char == text_to_set.length():
				writing_text = false
		else:
			time_since_last_char_write += 1


func write_next_char():
	$Control/NinePatchRect/Label.text += text_to_set.substr(next_char, 1)
	next_char += 1


func update_text(new_text):
	print("Updating the text.")
	$Control/NinePatchRect/Label.text = ""
	text_to_set = new_text
	next_char = 0
	writing_text = true
	
