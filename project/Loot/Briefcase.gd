extends Area2D


func _on_Briefcase_body_entered(body):
	get_tree().call_group("Loot", "collect_loot", "Briefcase")
	queue_free()
