extends Node2D

func _ready():
	$Player.attempts()
func _process(delta):
	if Global.attempts == 0:
		Global.win = false
		get_tree().change_scene_to_file("res://Levels/final.tscn")
func _on_area_2d_body_entered(body):
	if body.name == "Player":
		body.inv_press()
		get_tree().change_scene_to_file("res://Levels/final.tscn")


func _on_area_2d_1_body_entered(body):
	if body.name == "Player":
		body.q1()


func _on_area_2d_2_body_entered(body):
	if body.name == "Player":
		body.q2()


func _on_area_2d_3_body_entered(body):
	if body.name == "Player":
		body.q3()


func _on_area_2d_4_body_entered(body):
	if body.name == "Player":
		body.q4()
func q1unshow():
	$q1/correct/Label6.visible = false
	$q1/wrong/Label4.visible = false
	$q1/wrong2/Label5.visible = false
func q2unshow():
	$q2/correct/Label.visible = false
	$q2/wrong/Label3.visible = false
	$q2/wrong2/Label2.visible =false
func q3unshow():
	$q3/correct/Label9.visible = false
	$q3/wrong/Label7.visible = false
	$q3/wrong2/Label8.visible =false
func q4unshow():
	$q4/correct/Label12.visible = false
	$q4/wrong/Label11.visible = false
