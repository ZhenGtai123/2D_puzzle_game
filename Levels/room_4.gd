extends Node2D

var items = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for item in Global.collected_items:
		for item_node in $Items.get_children():
			if (item == item_node.name):
				item_node.queue_free()
	for item in $Items.get_children():
		items.append(item.name)
	if Global.current_location == "secret_room":
		$Player.position = $secret_area_spawn.position

func _on_area_2d_body_entered(body):
	if(body.is_in_group("player")):
		for item in $Items.get_children():
			items.erase(item.name)
		for item in items:
			Global.collected_items.append(item)
		Global.current_location = "room4"
		body.inv_press()
		get_tree().change_scene_to_file("res://Levels/hellius-corridoors.tscn")
		

func _on_secret_area_body_entered(body):
	if(body.is_in_group("player")):
		for item in $Items.get_children():
			items.erase(item.name)
		for item in items:
			Global.collected_items.append(item)
		Global.current_location = "room4"
		body.inv_press()
		get_tree().change_scene_to_file("res://Levels/secret_room.tscn")
