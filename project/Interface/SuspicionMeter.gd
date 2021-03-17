extends TextureProgress

# Increases how fast suspicion goes up vs goes down
export var suspicion_multiplier = 3


# Sets suspicion level to default
func _ready():
	value = 0


# Makes suspicion go down by step every frame
func _process(delta):
	value -= step


# If the player's seen, makes suspicion go up; ends game if caught
func player_seen():
	value += step * suspicion_multiplier

	if value == max_value:
		end_game()


# Currently quits game
# TODO: Create a game over screen
func end_game():
	get_tree().quit()

