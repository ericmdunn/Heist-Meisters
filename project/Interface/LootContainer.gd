extends NinePatchRect


var loot_icons = {
	"Briefcase":"res://Assets/GFX/Loot/suitcase.png"
}
func _ready():
	hide()


func collect_loot(loot_type):
	show()
	$VBoxContainer/ItemList.add_icon_item(load(loot_icons[loot_type]), false)


