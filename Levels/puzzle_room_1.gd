extends Node2D

var items = []
var correct_letters = 0
var triggered = false
func _ready():
	for item in Global.collected_items:
		for item_node in $Items.get_children():
			if (item == item_node.name):
				item_node.queue_free()
	for item in $Items.get_children():
		items.append(item.name)
	if (Global.completed_puzzle1 && !Global.claimed_puzzle1_reward):
		var K = preload("res://Scenes/inventory/items/K.tscn")
		var instance = K.instantiate()
		add_child(instance)
		instance.position = Vector2(-25,-80)
		instance.scale = instance.scale * 1/5

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		Global.claimed_puzzle1_reward = true
		for item in $Items.get_children():
			items.erase(item.name)
		for item in items:
			Global.collected_items.append(item)
		for child in get_children():
			if child.name == "K":
				Global.claimed_puzzle1_reward = false
		Global.current_location = "room1"
		body.inv_press()
		get_tree().change_scene_to_file("res://Levels/hellius-corridoors.tscn")

func activate_pressure_plate(plate):
	$Click.play()
	if (!Global.completed_puzzle1):
		if (correct_letters == 0 && plate == "H"):
			correct_letters = 1
		elif (correct_letters == 1 && plate == "E"):
			correct_letters = 2
		elif (correct_letters == 2 && plate == "L"):
			correct_letters = 3
		elif (correct_letters == 3 && plate == "L"):
			correct_letters = 4
			var K = preload("res://Scenes/inventory/items/K.tscn")
			var instance = K.instantiate()
			add_child(instance)
			instance.position = Vector2(-25,-80)
			instance.scale = instance.scale * 1/5
			Global.completed_puzzle1 = true
			items.append(instance.name)
		else:
			correct_letters = -1
		

func _on_h_body_entered(body):
	if body.is_in_group("player"):
		if triggered == false:
			activate_pressure_plate("H")
			triggered = true

func _on_e_body_entered(body):
	if body.is_in_group("player"):
		if triggered == false:
			activate_pressure_plate("E")
			triggered = true

func _on_l_body_entered(body):
	if body.is_in_group("player"):
		if triggered == false:
			activate_pressure_plate("L")
			triggered = true

func _on_wrong_body_entered(body):
	if body.is_in_group("player"):
		if triggered == false:
			activate_pressure_plate(" ")
			triggered = true

func _on_reset_body_entered(body):
	if body.is_in_group("player"):
		correct_letters = 0
		$Reset.play()

func _on_h_body_exited(body):
	if body.is_in_group("player"):
		if triggered == true:
			triggered = false
