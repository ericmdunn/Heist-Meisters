extends "res://NPCs/PlayerDetection.gd"


# This line is from the earlier iteration of make_path(), explained below above the old make_path() code
#onready var navigation = get_tree().get_root().find_node("Navigation2D", true, false)
onready var destinations = get_node("Destinations")

var direction = 1
var motion
var possible_destinations
var path = []


export var minimum_arrival_distance = 5
export var walk_speed = 0.5
export var move_in_loop = false


func _ready():
	randomize()
	if move_in_loop:
		$Timer.set_wait_time(0.01)
		print("Has set_wait_time been set properly?")
		print($Timer.get_wait_time())
	possible_destinations = destinations.get_children()
	print(name)
	for each in possible_destinations:
		print(each.position)
	make_path()


func _physics_process(delta):
	navigate()


func navigate():
	if path.size() > 0:
		var distance_to_destination = position.distance_to(path[0])
		if distance_to_destination > minimum_arrival_distance:
			move()
		else:
			update_path()
	elif $Timer.is_stopped():
		make_path()


func move():
	look_at(path[0])
	motion = (path[0] - position).normalized() * (MAX_SPEED * walk_speed)
	
	if is_on_wall():
		make_path()
	
	move_and_slide(motion)


func update_path():
	if path.size() == 1 and $Timer.is_stopped():
		$Timer.start()
	elif path.size() > 1:
		path.remove(0)


func make_path():
	if path.size() > 0:
		path.remove(0)
	
	if direction == 1 or move_in_loop:
		for destination in possible_destinations:
			path.push_back(destination.position)
		direction = -1
	else:
		for destination in possible_destinations:
			path.push_front(destination.position)
		direction = 1

# This is the old make_path which runs on random locations and uses
# get_smple_path(), which doesn't work very well. New make_path is above
#func make_path():
#	var random_number = randi() % possible_destinations.size()
#	print(random_number)
#	var new_destination = possible_destinations[random_number]
#	path = navigation.get_simple_path(position, new_destination.position, false)
#	print(path)


func _on_Timer_timeout():
	make_path()
