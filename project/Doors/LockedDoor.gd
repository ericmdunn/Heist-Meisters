extends "res://Doors/Door.gd"


export var lock_group = "unset"


func _ready():
	$Label.rect_rotation = -rotation_degrees


func _on_Door_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click:
		$CanvasLayer/Numpad.popup_centered()


func _on_Door_body_exited(body):
	if body.collision_layer == 1:
		can_click = false
		$CanvasLayer/Numpad.hide()



func _on_Numpad_combination_correct():
	open()
	$CanvasLayer/Numpad.hide()

# Removed when the generation of the combination was changed to the computer
#func generate_combination():
#	var combination = CombinationGenerator.generate_combination(6)
#	$CanvasLayer/Numpad.combination = combination
#	print(str(combination))


func _on_Computer_combination(combination, lock_group_emitter):
	if lock_group_emitter == lock_group:
		$CanvasLayer/Numpad.combination = combination
		$Label.text = lock_group



