extends Button

@onready var item_visual: Sprite2D = $Panel/item_display
@onready var amount: Label = $Panel/Label
@onready var n: Label = $Panel/name
# Called when the node enters the scene tree for the first time.

func add(slot: InvSlot):
	if !slot.item:
		item_visual.visible = false
		amount.visible = false
	else: 
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		if slot.amount >= 1: 
			amount.visible = true
		amount.text = str(slot.amount)
		n.text = slot.item.name
		

func clear():
	self.item_visual.texture = null
	self.amount.text = ""
	self.n.text =""

