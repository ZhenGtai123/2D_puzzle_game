extends Node2D

var in_range = false 
var player
func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player = body
		in_range = true
			

func _physics_process(delta):
	if in_range && Input.is_action_just_pressed("use"): 
		$AudioStreamPlayer2D.play()
		in_range = false
		$AudioStreamPlayer2D.play()
		$Sprite2D.visible = false
		$RigidBody2D/CollisionShape2D.disabled = true
		$Area2D.queue_free()
		Global.steps += 1
		if Global.steps == 1:
			self.get_parent().get_parent().q1unshow()
		else:
			if Global.steps == 2:
				self.get_parent().get_parent().q2unshow()
			else:
				if Global.steps ==3:
					self.get_parent().get_parent().q3unshow()
				else:
					if Global.steps == 4: 
						self.get_parent().get_parent().q4unshow()


func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		
		in_range = false

