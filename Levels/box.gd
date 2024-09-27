extends Node2D

var in_range = false 
var wood = load("res://Scenes/inventory/items/wood.tscn")
var player
func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player = body
		body.showbreak()
		in_range = true
			

func _physics_process(delta):
	if in_range && Input.is_action_just_pressed("use"): 
		in_range = false
		$AudioStreamPlayer2D.play()
		$Sprite2D.visible = false
		$RigidBody2D/CollisionShape2D.disabled = true
		$Area2D.queue_free()
		$Timer.start()
		
		for i in range(4):
			var wood_item = wood.instantiate()
			add_child(wood_item)
		await $Timer.timeout
		player.show_inventory()


func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		
		in_range = false

