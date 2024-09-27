extends Node2D

var items = []
var triggered = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.reset()
	for item in Global.collected_items:
		for item_node in $Items.get_children():
			if (item == item_node.name):
				item_node.queue_free()
	for item in $Items.get_children():
		items.append(item.name)
	if (Global.puzzle3_door1_opened):
		for node in $Doors/Door2.get_children():
			node.queue_free()
		$TileMap.set_cell(1,Vector2i(3,-2),2,Vector2i(10,2),1)
		$TileMap.set_cell(1,Vector2i(3,-1),2,Vector2i(11,2),1)
	if (Global.puzzle3_door2_opened):
		for node in $Doors/Door7.get_children():
			node.queue_free()
		$TileMap.set_cell(1,Vector2i(-6,1),2,Vector2i(10,2),1)
		$TileMap.set_cell(1,Vector2i(-6,2),2,Vector2i(11,2),1)
func _physics_process(delta):
	if Input.is_action_just_pressed("use"): 
		reset()
		
func _on_pressure_plate_1_body_entered(body):
	if body.is_in_group("player"):
		if (triggered == false):
			$Click.play()
			$TileMap.set_cell(1,Vector2i(3,-6))
			$TileMap.set_cell(1,Vector2i(3,-5))
			$TileMap.set_cell(1,Vector2i(4,-6))
			$TileMap.set_cell(1,Vector2i(4,-5))
			$Doors/Door1.set_collision_layer_value(1, false)
			$TileMap.set_cell(1,Vector2i(6,1))
			$TileMap.set_cell(1,Vector2i(6,2))
			$TileMap.set_cell(1,Vector2i(7,1))
			$TileMap.set_cell(1,Vector2i(7,2))
			$Doors/Door3.set_collision_layer_value(1, false)
			triggered = true
			$Timer_1.start()
			await $Timer_1.timeout
			$TileMap.set_cell(1,Vector2i(3,-6),1,Vector2i(24,12),1)
			$TileMap.set_cell(1,Vector2i(3,-5),1,Vector2i(26,12),1)
			$TileMap.set_cell(1,Vector2i(4,-6),1,Vector2i(24,10),1)
			$TileMap.set_cell(1,Vector2i(4,-5),1,Vector2i(26,10),1)
			$Doors/Door1.set_collision_layer_value(1, true)
			$TileMap.set_cell(1,Vector2i(6,1),1,Vector2i(24,12),1)
			$TileMap.set_cell(1,Vector2i(6,2),1,Vector2i(26,12),1)
			$TileMap.set_cell(1,Vector2i(7,1),1,Vector2i(24,10),1)
			$TileMap.set_cell(1,Vector2i(7,2),1,Vector2i(26,10),1)
			$Doors/Door3.set_collision_layer_value(1, true)

func _on_pressure_plate_3_body_entered(body):
	if body.is_in_group("player"):
		if (triggered == false):
			$Click.play()
			$TileMap.set_cell(1,Vector2i(1,0))
			$TileMap.set_cell(1,Vector2i(1,1))
			$TileMap.set_cell(1,Vector2i(2,0))
			$TileMap.set_cell(1,Vector2i(2,1))
			$Doors/Door4.set_collision_layer_value(1, false)
			triggered = true
			$Timer_2.start()
			await $Timer_2.timeout
			$TileMap.set_cell(1,Vector2i(1,0),1,Vector2i(24,12),2)
			$TileMap.set_cell(1,Vector2i(1,1),1,Vector2i(24,10),2)
			$TileMap.set_cell(1,Vector2i(2,0),1,Vector2i(26,12),2)
			$TileMap.set_cell(1,Vector2i(2,1),1,Vector2i(26,10),2)
			$Doors/Door4.set_collision_layer_value(1, true)


func _on_pressure_plate_5_body_entered(body):
	if body.is_in_group("player"):
		if (triggered == false):
			$Click.play()
			$TileMap.set_cell(1,Vector2i(1,3))
			$TileMap.set_cell(1,Vector2i(1,4))
			$TileMap.set_cell(1,Vector2i(2,3))
			$TileMap.set_cell(1,Vector2i(2,4))
			$Doors/Door5.set_collision_layer_value(1, false)
			$TileMap.set_cell(1,Vector2i(4,3))
			$TileMap.set_cell(1,Vector2i(4,4))
			$TileMap.set_cell(1,Vector2i(5,3))
			$TileMap.set_cell(1,Vector2i(5,4))
			$Doors/Door6.set_collision_layer_value(1, false)
			triggered = true
			$Timer_3.start()
			await $Timer_3.timeout
			$TileMap.set_cell(1,Vector2i(1,3),1,Vector2i(24,12),2)
			$TileMap.set_cell(1,Vector2i(1,4),1,Vector2i(24,10),2)
			$TileMap.set_cell(1,Vector2i(2,3),1,Vector2i(26,12),2)
			$TileMap.set_cell(1,Vector2i(2,4),1,Vector2i(26,10),2)
			$Doors/Door5.set_collision_layer_value(1, true)
			$TileMap.set_cell(1,Vector2i(4,3),1,Vector2i(24,12),2)
			$TileMap.set_cell(1,Vector2i(4,4),1,Vector2i(24,10),2)
			$TileMap.set_cell(1,Vector2i(5,3),1,Vector2i(26,12),2)
			$TileMap.set_cell(1,Vector2i(5,4),1,Vector2i(26,10),2)
			$Doors/Door6.set_collision_layer_value(1, true)

func _on_pressure_plate_body_exited(body):
	if body.is_in_group("player"):
		if triggered == true:
			triggered = false

func _on_door2_body_entered(body):
	if body.is_in_group("player"):
		if ($Player.check_inventory("key2")):
			$Player.use_item("key2", 1)		
			$Player/Door_open_sound.play()
			for node in $Doors/Door2.get_children():
				node.queue_free()
			$TileMap.set_cell(1,Vector2i(3,-2))
			$TileMap.set_cell(1,Vector2i(3,-1))
			Global.puzzle3_door1_opened = true
		else:
			$Player.needkey()


func _on_Door7_body_entered(body):
	if body.is_in_group("player"):
		if ($Player.check_inventory("key2")):
			$Player.use_item("key2", 1)		
			$Player/Door_open_sound.play()
			for node in $Doors/Door7.get_children():
				node.queue_free()
			$TileMap.set_cell(1,Vector2i(-6,1))
			$TileMap.set_cell(1,Vector2i(-6,2))
			Global.puzzle3_door2_opened = true
		else:
			$Player.needkey()

func _on_area_2d_body_entered(body):
	if(body.is_in_group("player")):
		for item in $Items.get_children():
			items.erase(item.name)
		for item in items:
			Global.collected_items.append(item)
		Global.current_location = "room3"
		body.inv_press()
		get_tree().change_scene_to_file("res://Levels/hellius-corridoors.tscn")
func reset():
	$Player.position.x = -126
	$Player.position.y = -26
