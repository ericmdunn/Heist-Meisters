extends CanvasModulate

# Color of overlay for all vision modes
const DARK = Color("111111")
const NIGHTVISION = Color("36c032")


# Default to dark mode
func _ready():
	visible = true
	color = DARK


func cycle_vision_mode():
	# If toggling is off cooldown, swap the mode and restart the timer
	if $Timer.is_stopped():
		if color == NIGHTVISION:
			DARK_mode()
		else:
			NIGHTVISION_mode()
		$Timer.start()


func DARK_mode():
	# Set dark mode by changing the color, playing the nightvision off sound,
	# and show lights and hide labels
	color = DARK
	$AudioStreamPlayer2D.stream = load("res://Assets/SFX/nightvision_off.wav")
	$AudioStreamPlayer2D.play()
	get_tree().call_group("lights", "show")
	get_tree().call_group("labels", "hide")


func NIGHTVISION_mode():
	# Set night vision mode by changing the color, playing the nightvision on sound,
	# and show labels and hide lights
	color = NIGHTVISION
	$AudioStreamPlayer2D.stream = load("res://Assets/SFX/nightvision.wav")
	$AudioStreamPlayer2D.play()
	get_tree().call_group("lights", "hide")
	get_tree().call_group("labels", "show")




