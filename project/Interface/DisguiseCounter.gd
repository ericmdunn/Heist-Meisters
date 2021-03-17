extends ItemList

func update_disguises(new_disguise_count):
	clear()
	for disguise in range (new_disguise_count):
		add_icon_item(load("res://Assets/GFX/PNG/Tiles/tile_156.png"), false)
