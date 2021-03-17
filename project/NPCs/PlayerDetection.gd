extends "res://Characters/TemplateCharacter.gd"


# FOV_TOLERANCE is the angle +/- over which detection occurs
const FOV_TOLERANCE = 20
# Distance over which detection occurs
const MAX_DETECTION_RANGE = 640
# Color constants
const RED = Color(1, 0.25, 0.25)
const WHITE = Color (1, 1, 1)

var Player


# Find where the player character is in the game
func _ready():
	Player = get_node("/root").find_node("PlayerCharacter", true, false)


# Check if player is detected every frame
func _process(delta):
	if is_Player_in_FOV() and is_Player_in_LOS():
		# Player is detected
		$Flashlight.color = RED
		get_tree().call_group("suspicionMeter", "player_seen")
	else:
		# Player is not detected
		$Flashlight.color = WHITE


func is_Player_in_FOV():
	var npc_facing_direction = Vector2(1, 0).rotated(global_rotation)
	var direction_to_Player = (Player.position - global_position).normalized()
	
	# Gets the angle between Player and NPC and sees if its absolute value is less than FOV_TOLERANCE
	if abs(direction_to_Player.angle_to(npc_facing_direction)) < deg2rad(FOV_TOLERANCE):
		return true
	else:
		return false


func is_Player_in_LOS():
	var space = get_world_2d().direct_space_state
	# Creates a line between NPC and Player to see if anything is in between them
	var LOS_obstacle = space.intersect_ray(global_position, Player.global_position, [self], collision_mask)
	
	# If there's no line in between NPC and Player?
	if not LOS_obstacle:
		return false
	
	# Get distance between NPC and Player
	var distance_to_player = Player.global_position.distance_to(global_position)
	
	# If LOS_obstacle collides with player and not something else on the way, and
	# Player is less than MAX_DETECTION_RANGE away
	if LOS_obstacle.collider == Player and distance_to_player < MAX_DETECTION_RANGE:
		return true
	else:
		return false




