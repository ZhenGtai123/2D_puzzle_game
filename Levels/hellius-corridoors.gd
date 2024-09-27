extends Node2D

func _ready():
	if Global.current_location == "room1":
		$Player.position = $Spawn_locations/room1.position
	elif Global.current_location == "room2":
		$Player.position = $Spawn_locations/room2.position
	elif Global.current_location == "room3":
		$Player.position = $Spawn_locations/room3.position
	elif Global.current_location == "room4":
		$Player.position = $Spawn_locations/room4.position
	elif Global.current_location == "room5":
		$Player.position = $Spawn_locations/room5.position
	elif Global.current_location == "room6":
		$Player.position = $Spawn_locations/room6.position
	elif Global.current_location == "room0":
		$Player.position = $Spawn_locations/room0.position

func _on_puzzle_room_1_body_entered(body):
	if body.is_in_group("player"):
		body.inv_press()
		get_tree().change_scene_to_file("res://Levels/puzzle_room_1.tscn")
		body.inv_clear()

func _on_puzzle_room_2_body_entered(body):
	if body.is_in_group("player"):
		body.inv_press()
		get_tree().change_scene_to_file("res://Levels/puzzle_room_2.tscn")
		body.inv_clear()

func _on_puzzle_room_3_body_entered(body):
	if body.is_in_group("player"):
		body.inv_press()
		get_tree().change_scene_to_file("res://Levels/puzzle_room_3.tscn")
		body.inv_clear()

func _on_room_4_body_entered(body):
	if body.is_in_group("player"):
		body.inv_press()
		get_tree().change_scene_to_file("res://Levels/room_4.tscn")
		body.inv_clear()

func _on_room_5_body_entered(body):
	if body.is_in_group("player"):
		body.inv_press()
		get_tree().change_scene_to_file("res://Levels/puzzle_room_5.tscn")
		body.inv_clear()

func _on_room_6_body_entered(body):
	if body.is_in_group("player"):
		body.inv_press()
		get_tree().change_scene_to_file("res://Levels/room_6.tscn")
		body.inv_clear()


func _on_puzzle_room_4_body_entered(body):
	if body.is_in_group("player"):
		if(body.check_inventory("final_key")):
			body.inv_press()
			body.use_item("final_key", 1)
			get_tree().change_scene_to_file("res://Levels/corridor-devil.tscn")
		else:
			$puzzle_room4/AudioStreamPlayer2D.play()
			body.no_final_key()


func _on_room_0_body_entered(body):
	if body.is_in_group("player"):
		body.inv_press()
		Global.current_location = "corridors"
		get_tree().change_scene_to_file("res://Levels/node_2d.tscn")
		body.inv_clear()
