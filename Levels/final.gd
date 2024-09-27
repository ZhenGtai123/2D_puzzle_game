extends Node2D

func _ready():
	if Global.win == true:
		$Success.visible = true
		$Fail.visible = false
		$Credits.visible = false
		$Credits2.visible = false
		$Credits3.visible = false
		$win.play()
	else:
		$Success.visible = false
		$Fail.visible = true
		$Credits.visible = false
		$Credits2.visible = false
		$Credits3.visible = false
		$lose.play()


func _on_timer_timeout():
	$Success.visible = false
	$Fail.visible = false
	$Credits.visible = true
	$Credits2.visible = true
	$Credits3.visible = true
