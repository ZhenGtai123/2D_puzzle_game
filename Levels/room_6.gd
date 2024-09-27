extends Node2D

var items = []
var triggered = false
var correct = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	for item in Global.collected_items:
		for item_node in $Items.get_children():
			if (item == item_node.name):
				item_node.queue_free()
	for item in $Items.get_children():
		items.append(item.name)
	if (Global.completed_puzzle6 && !Global.claimed_puzzle6_reward):
		var Y = preload("res://Scenes/inventory/items/Y.tscn")
		var instance = Y.instantiate()
		add_child(instance)
		instance.position = Vector2(-15,-45)
		instance.scale = instance.scale * 1/5

func _on_area_2d_body_entered(body):
	if(body.is_in_group("player")):
		Global.claimed_puzzle6_reward = true
		for item in $Items.get_children():
			items.erase(item.name)
		for item in items:
			Global.collected_items.append(item)
		for child in get_children():
			if child.name == "Y":
				Global.claimed_puzzle6_reward = false
		Global.current_location = "room6"
		body.inv_press()
		body.inv_clear()
		get_tree().change_scene_to_file("res://Levels/hellius-corridoors.tscn")
		

func activate_pressure_plate(plate):
	$Click.play()
	if (!Global.completed_puzzle6):
		if (correct == 0 && plate == 1):
			correct = 1
		elif (correct == 1 && plate == 2):
			correct = 2
		elif (correct == 2 && plate == 3):
			correct = 3
		elif (correct == 3 && plate == 4):
			correct = 4
			var Y = preload("res://Scenes/inventory/items/Y.tscn")
			var instance = Y.instantiate()
			add_child(instance)
			instance.position = Vector2(-15,-45)
			instance.scale = instance.scale * 1/5
			Global.completed_puzzle6 = true
			items.append(instance.name)
		else:
			correct = -1

func _on_1_body_entered(body):
	if body.is_in_group("player"):
		if triggered == false:
			activate_pressure_plate(1)
			triggered = true

func _on_2_body_entered(body):
	if body.is_in_group("player"):
		if triggered == false:
			activate_pressure_plate(2)
			triggered = true

func _on_3_body_entered(body):
	if body.is_in_group("player"):
		if triggered == false:
			activate_pressure_plate(3)
			triggered = true

func _on_4_body_entered(body):
	if body.is_in_group("player"):
		if triggered == false:
			activate_pressure_plate(4)
			triggered = true

func _on_wrong_body_entered(body):
	if body.is_in_group("player"):
		if triggered == false:
			activate_pressure_plate(0)
			triggered = true

func _on_reset_body_entered(body):
	if body.is_in_group("player"):
		correct = 0
		$Reset.play()

func _on_body_exited(body):
	if body.is_in_group("player"):
		if triggered == true:
			triggered = false
