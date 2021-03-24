extends Node2D


func _ready():
	yield(get_tree(), "idle_frame")
	update_pointer_positions(0)


func update_pointer_positions(objective_number):
	var pointer = $ObjectivePointer
	var objective_position = $ObjectivePositions.get_child(objective_number)
	var message = $ObjectiveMessages.get_child(objective_number)
	
	$Tween.interpolate_property(pointer, "position", pointer.position,
	objective_position.position, 1.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.start()
	
	$TutorialGUI/Control/NinePatchRect/Label.text = message.message
	$MessageSound.play()


func _on_MoveObjective_body_entered(body):
	update_pointer_positions(1)


func _on_NightVisionObjective_body_entered(body):
	update_pointer_positions(2)


func _on_DoorObjective_body_entered(body):
	update_pointer_positions(3)


func _on_BriefcaseObjective_body_entered(body):
	update_pointer_positions(4)



