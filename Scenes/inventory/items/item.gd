extends Node2D

@export var item: InvItem
var player = null

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player = body
		if player.collect(item):
			self.queue_free()
			
