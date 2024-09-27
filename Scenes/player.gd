extends CharacterBody2D
var lastdir = Vector2(0,0)

@export var SPEED = 200.0

@export var inv: Inv



func _physics_process(delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	if input_direction.x == -1:
		$AnimatedSprite2D.play("left_walk")
		lastdir = Vector2(-1,0)
	elif input_direction.x == 1:
		$AnimatedSprite2D.play("right_walk")
		lastdir = Vector2(1,0)
	elif input_direction.y == 1:
		$AnimatedSprite2D.play("down_walk")
		lastdir = Vector2(0,1)
	elif input_direction.y == -1:
		$AnimatedSprite2D.play("up_walk")
		lastdir = Vector2(0,-1)
		
	velocity = input_direction * SPEED
	move_and_slide()
	
	if velocity.length() == 0:
		if lastdir.x == -1:
			$AnimatedSprite2D.play("left")
		elif lastdir.x == 1:
			$AnimatedSprite2D.play("right")
		elif lastdir.y == 1:
			$AnimatedSprite2D.play("down")
		elif lastdir.y == -1:
			$AnimatedSprite2D.play("up")
	

func collect(item):

	if !inv.slots.filter(func(slot): return slot.item == null).is_empty():
		$pick_up_sound.play()
		inv.insert(item)
		return true
	else:
		return false
	
	$pick_up_sound.play()
	inv.insert(item)
	
func check_inventory(item):
	for i in range(inv.slots.size()):
			if (inv.slots[i].item):
				if (inv.slots[i].item.name == item && inv.slots[i].amount >=1):
					return true
	return false

func use_item(item, amount):
	for i in range(inv.slots.size()):
			if (inv.slots[i].item):
				if (inv.slots[i].item.name == item):
					inv.slots[i].amount = inv.slots[i].amount - amount
					$Inventory.update_slots()
					return
					

func inv_press():
	$Inventory.press_all()
	
func no_final_key():
	$no_final_key.visible = true
	$Timer2s.start()
	await $Timer2s.timeout
	$no_final_key.visible = false
func move():
	$move.visible = true
	$Timer3s.start()
	await $Timer3s.timeout
	$move.visible = false
	
func showbreak():
	$move.visible = false
	$need_key.visible = false
	$break.visible = true
	$Timer2s.start()
	await $Timer2s.timeout
	$break.visible = false
func needkey():
	$inventory.visible = false
	$wrong.play()
	$no_key.play()
	$move.visible = false
	$break.visible = false
	$need_key.visible = true
	$Timer2s.start()
	await $Timer2s.timeout
	$need_key.visible = false
func show_inventory():
	$need_key.visible = false
	$move.visible = false
	$break.visible = false
	$inventory.visible = true
	$Timer3s.start()
	await $Timer3s.timeout
	$inventory.text = "You can try crafting with 3 wood and a key"
	$Timer3s.start()
	await $Timer3s.timeout
	$inventory.visible = false
func inv_clear():
	$Inventory.clear_empty()

func reset():
	$reset.visible = true
	$Timer3s.start()
	await $Timer3s.timeout
	$reset.visible = false

func attempts():
	$q2.visible = false
	$q1.visible =false
	$q3.visible = false
	$q4.visible = false
	if Global.attempts == 2:
		$attempts.text = "You have 2 attempts left"
	if Global.attempts == 1:
		$attempts.text = "This is your final attempt"
	$attempts.visible = true
	$Timer3s.start()
	await $Timer3s.timeout
	$attempts.visible = false
	
func q1():
	$attempts.visible = false
	$q2.visible = false
	$q1.visible = true
	$Timer3s.start()
	await $Timer3s.timeout
	$q1.visible = false
func q2():
	$attempts.visible = false
	$q1.visible = false
	$q3.visible = false
	$q2.visible = true
	$Timer3s.start()
	await $Timer3s.timeout
	$q2.visible = false
	
func q3():
	$attempts.visible = false
	$q2.visible = false
	$q3.visible = true
	$Timer3s.start()
	await $Timer3s.timeout
	$q3.visible = false
func q4():
	$attempts.visible = false
	$q3.visible = false
	$q4.visible = false
	$q4.visible = true
	$Timer3s.start()
	await $Timer3s.timeout
	$q4.visible = false
