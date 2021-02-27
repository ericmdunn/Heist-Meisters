extends Popup

var combination = [0,4,5,1]
var guess = []

onready var display = $VBoxContainer/DisplayContainer/Display
onready var light = $VBoxContainer/ButtonContainer/GridContainer/StatusLight


signal combination_correct


func _ready():
	connect_buttons()
	reset_lock()


func connect_buttons():
	for child in $VBoxContainer/ButtonContainer/GridContainer.get_children():
		if child is Button:
			child.connect("pressed", self, "Button_pressed", [child.text])


func Button_pressed(button):
	if button == "#":
		check_guess()
	else:
		enter(int(button))


func check_guess():
	if guess == combination:
		$AudioStreamPlayer.stream = load("res://Assets/SFX/threeTone1.ogg")
		$AudioStreamPlayer.play()
		light.texture = load("res://Assets/GFX/Interface/PNG/dotGreen.png")
		$Timer.start()

	else:
		reset_lock()


func enter(button):
	$AudioStreamPlayer.stream = load("res://Assets/SFX/twoTone1.ogg")
	$AudioStreamPlayer.play()
	guess.append(button)
	update_display()


func update_display():
	display.text = PoolStringArray(guess).join("")

	if guess.size() == combination.size():
		check_guess()


func reset_lock():
	display.text = ""
	guess.clear()
	light.texture = load("res://Assets/GFX/Interface/PNG/dotRed.png")




func _on_Timer_timeout():
	emit_signal("combination_correct")
	reset_lock()
