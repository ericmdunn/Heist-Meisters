extends CanvasModulate

const DARK = Color("111111")
const NIGHTVISION = Color("36c032")


func _ready():
	visible = true
	color = DARK


func cycle_vision_mode():
	if $Timer.is_stopped():
		if color == NIGHTVISION:
			DARK_mode()
		else:
			NIGHTVISION_mode()
		$Timer.start()


func DARK_mode():
	color = DARK
	$AudioStreamPlayer2D.stream = load("res://Assets/SFX/nightvision_off.wav")
	$AudioStreamPlayer2D.play()
	get_tree().call_group("lights", "show")
	get_tree().call_group("labels", "hide")


func NIGHTVISION_mode():
	color = NIGHTVISION
	$AudioStreamPlayer2D.stream = load("res://Assets/SFX/nightvision.wav")
	$AudioStreamPlayer2D.play()
	get_tree().call_group("lights", "hide")
	get_tree().call_group("labels", "show")




