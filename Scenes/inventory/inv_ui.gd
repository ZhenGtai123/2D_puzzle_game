extends Control

@onready var inv: Inv = preload("res://Scenes/inventory/player_inv1.tres")
@onready var slots:Array = $NinePatchRect/GridContainer.get_children()
@onready var grabbed_slot: Panel = $grabbed_slot
@onready var craft_slots: Array = $craft/NinePatchRect2/GridContainer.get_children()
@onready var next_key: InvItem = preload("res://Scenes/inventory/items/next_key.tres")
@onready var final_key: InvItem = preload("res://Scenes/inventory/items/final_key.tres")
var is_open  = false

func _ready():
	update_slots()
	inv.update.connect(update_slots)
	connectSlots()
	close()
	
func connectSlots():
	for slot in slots:
		slot.pressed.connect(on_slot_clicked.bind(slot))
	for slot in craft_slots:
		slot.pressed.connect(on_craft_slot_clicked.bind(slot))

func _process(delta):
	
	
	if Input.is_action_just_pressed("inventory"):
		
		if is_open: 
			close()

		else: 
			open()
	

func close():
	visible = false
	is_open = false

func open():
	visible = true
	is_open = true

func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		
		slots[i].update(inv.slots[i])
func clear_empty():
	for i in range(min(inv.slots.size(), slots.size())):
		if (inv.slots[i].amount == 0 && inv.slots[i].item):
			inv.slots[i].item = null
		slots[i].update(inv.slots[i])

func on_slot_clicked(slot):
	if int(slot.amount.text) >= 1:
		if !grabbed_slot.visible:
			grabbed_slot.item_visual.texture = slot.item_visual.texture
			grabbed_slot.amount.text = slot.amount.text
			grabbed_slot.n.text = slot.n.text
			update_grabbed_slot()
			
			slot.clear()
		else:
			
			update_grabbed_slot()
			update_slots()
		
	else:
		if grabbed_slot.visible:
			update_grabbed_slot()
			update_slots()
		
func on_craft_slot_clicked(slot):
	if int(slot.amount.text) >= 1:
		if !grabbed_slot.visible:
			inv.add(slot.item_visual.texture)
			#grabbed_slot.amount.text = str(int(grabbed_slot.amount.text) +1)
			update_slots()
			slot.clear()
		else:
			update_grabbed_slot()
			update_slots()
		
	else:
		if grabbed_slot.visible:
			slot.amount.text = "1"
			slot.item_visual.texture = grabbed_slot.item_visual.texture
			slot.n.text = grabbed_slot.n.text
			inv.delete(int(grabbed_slot.amount.text), grabbed_slot.item_visual.texture)
			grabbed_slot.amount.text = str(int(grabbed_slot.amount.text) -1)
			update_grabbed_slot()
			update_slots()
	
func update_grabbed_slot()-> void:
	grabbed_slot.visible = !grabbed_slot.visible
		
func _physics_process(delta):
	if grabbed_slot.visible:
		grabbed_slot.global_position = get_global_mouse_position() + Vector2(1,1)

func press_all():
	if grabbed_slot.visible:
		update_grabbed_slot()
		
	for slot in craft_slots:
		slot.emit_signal("pressed")
	$craft/final_slot.emit_signal("pressed")

func _on_craft_button_pressed():
	var woodlist = craft_slots.filter(func(slot): 
		return slot.n.text == "wood")
	var keylist = craft_slots.filter(func(slot): 
		return slot.n.text == "key")
	if keylist.size() == 1 && woodlist.size() == 3:
		$craft/final_slot/item_display2.texture = load("res://asstes/inventory/key.png")
		$craft/final_slot/craft_sound.play()
		$craft/final_slot/name.text = "next_key"
		for slot in craft_slots:
			slot.clear()
	var nextkey_list = craft_slots.filter(func(slot): 
		return slot.n.text == "next_key")
	var k_list = craft_slots.filter(func(slot): 
		return slot.n.text == "K")
	var e_list = craft_slots.filter(func(slot): 
		return slot.n.text == "E")
	var y_list = craft_slots.filter(func(slot): 
		return slot.n.text == "Y")	
	if nextkey_list.size() ==1 && k_list.size() == 1 && y_list.size() == 1 && e_list.size() ==1:
		$craft/final_slot/item_display2.texture = load("res://asstes/inventory/key (1).png")
		$craft/final_slot/craft_sound.play()
		$craft/final_slot/name.text = "final_key"
		for slot in craft_slots:
			slot.clear()
	
		


func _on_final_slot_pressed():
	if !$craft/final_slot/item_display2.texture == null:
		if $craft/final_slot/name.text == "next_key":
			inv.insert(next_key)
			$craft/final_slot/item_display2.texture = null
			$craft/final_slot/name.text = ""
			clear_empty()
			goodluck()
		else:
			if $craft/final_slot/name.text == "final_key":
				inv.insert(final_key)
				$craft/final_slot/item_display2.texture = null
				$craft/final_slot/name.text = ""
				clear_empty()
func goodluck():
	$goodluck.visible = true
	$Timer2s.start()
	await $Timer2s.timeout
	$goodluck.visible = false
