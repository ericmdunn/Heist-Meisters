extends "res://Characters/TemplateCharacter.gd"


var motion = Vector2()
var is_disguised = false
var can_move= true


export var disguise_duration = 5
export var number_of_disguises = 3


const PLAYER_SPRITE = "res://Assets/GFX/PNG/Hitman 1/hitman1_stand.png"
const BOX_SPRITE = "res://Assets/GFX/PNG/Tiles/tile_130.png"
const PLAYER_OCCLUDER = "res://Characters/HumanOccluder.tres"
const BOX_OCCLUDER = "res://Characters/BoxOccluder.tres"
const PLAYER_LIGHT = "res://Assets/GFX/PNG/Hitman 1/hitman1_stand.png"
const BOX_LIGHT = "res://Assets/GFX/PNG/Tiles/tile_130.png"


func _ready():
	reveal()


func _physics_process(delta):
	update_movement()
	move_and_slide(motion)
	
	if is_disguised:
		$DisguiseLabel.text = str($Timer.time_left).pad_decimals(2)


func update_movement():
	if can_move:
		look_at(get_global_mouse_position())
		if Input.is_action_pressed("move_down") and not Input.is_action_pressed("move_up"):
			motion.y = clamp(motion.y + SPEED, 0, MAX_SPEED)
		elif Input.is_action_pressed("move_up") and not Input.is_action_pressed("move_down"):
			motion.y = clamp(motion.y - SPEED, -MAX_SPEED, 0)
		else:
			motion.y = lerp(motion.y, 0, FRICTION)
		if Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
			motion.x = clamp(motion.x - SPEED, -MAX_SPEED, 0)
		elif Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
			motion.x = clamp(motion.x + SPEED, 0, MAX_SPEED)
		else:
			motion.x = lerp(motion.x, 0, FRICTION)
	else:
		motion.y = lerp(motion.y, 0, FRICTION)
		motion.x = lerp(motion.x, 0, FRICTION)


func _input(event):
	if event.is_action_pressed("toggle_vision_mode"):
		get_tree().call_group("Interface", "cycle_vision_mode")
	if event.is_action_pressed("toggle_disguise"):
		toggle_disguise()


func toggle_disguise():
	if is_disguised:
		reveal()
	elif number_of_disguises > 0:
		disguise()


func reveal():
	$Sprite.texture = load(PLAYER_SPRITE)
	$Light2D.texture = load(PLAYER_LIGHT)
	$LightOccluder2D.occluder = load(PLAYER_OCCLUDER)
	$DisguiseLabel.hide()
	is_disguised = false
	collision_layer = 1
	can_move = true


func disguise():
	$Sprite.texture = load(BOX_SPRITE)
	$Light2D.texture = load(BOX_LIGHT)
	$LightOccluder2D.occluder = load(BOX_OCCLUDER)
	is_disguised = true
	collision_layer = 16
	can_move = false
	number_of_disguises -= 1
	
	$DisguiseLabel.show()
	$DisguiseLabel.set_global_position(position + Vector2(20, -40))
	$DisguiseLabel.set_rotation(-rotation)
	
	$Timer.wait_time = disguise_duration
	$Timer.start()









