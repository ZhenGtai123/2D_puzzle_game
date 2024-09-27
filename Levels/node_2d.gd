extends Node2D

var items = []

func _ready():
	if (Global.current_location == "corridors"):
		for item in Global.collected_items:
			for item_node in $Items.get_children():
				if (item == item_node.name):
					item_node.queue_free()
		for item in $Items.get_children():
			items.append(item.name)
		$Player.position = $Marker2D.position
		$box.queue_free()
		$TileMap.set_cell(1,Vector2i(13,26),1,Vector2i(10,2),1)
		$TileMap.set_cell(1,Vector2i(13,27),1,Vector2i(11,2),1)
	else:
		$Player.move()
		for item in Global.collected_items:
			for item_node in $Items.get_children():
				if (item == item_node.name):
					item_node.queue_free()
		for item in $Items.get_children():
			items.append(item.name)

func _on_door_3_area_body_entered(body):
	if body.is_in_group("player") and !Global.opened_door1:
		if ($Player.check_inventory("key2")):
			for item in $Items.get_children():
				items.erase(item.name)
			for item in items:
				Global.collected_items.append(item)
			$Player.use_item("key2", 1)
			$Player/Inventory.press_all()
			Global.current_location = "room0"
			Global.opened_door1 = true
			get_tree().change_scene_to_file("res://Levels/hellius-corridoors.tscn")
			$Player/Inventory.clear_empty()
			$Player/Door_open_sound.play()
		else: 
			$Player.needkey()
	elif body.is_in_group("player"):
		for item in $Items.get_children():
				items.erase(item.name)
		for item in items:
			Global.collected_items.append(item)
		$Player/Inventory.press_all()
		Global.current_location = "room0"
		get_tree().change_scene_to_file("res://Levels/hellius-corridoors.tscn")
		$Player/Inventory.clear_empty()
		$Player/Door_open_sound.play()
