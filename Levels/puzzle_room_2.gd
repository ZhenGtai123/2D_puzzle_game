extends Node2D

var items = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in $Fire.get_children():
		for children in child.get_children():
			if (children.name == "Fire"):
				children.play("Fire")
	for item in Global.collected_items:
		for item_node in $Items.get_children():
			if (item == item_node.name):
				item_node.queue_free()
	for item in $Items.get_children():
		items.append(item.name)
	
func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		$Player.position.x = -2
		$Player.position.y = -90
		await get_tree().create_timer(0.05).timeout
		if ($Items.get_child_count() == 0 && !Global.completed_puzzle2):
			$Player.use_item("Code2", 1)
			var Code2 = preload("res://Scenes/inventory/items/Code2.tscn")
			var instance = Code2.instantiate()
			var Items = $Items
			Items.add_child(instance)
			instance.position = Vector2(21,22)
			instance.scale = instance.scale * 1/5


func _on_door_body_entered(body):
	if body.is_in_group("player"):
		for item in $Items.get_children():
			items.erase(item.name)
		for item in items:
			Global.collected_items.append(item)
			if (item == "Code2"):
				Global.completed_puzzle2 = true
		Global.current_location = "room2"
		body.inv_press()
		get_tree().change_scene_to_file("res://Levels/hellius-corridoors.tscn")
