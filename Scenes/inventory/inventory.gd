extends Resource

class_name Inv

signal update

@export var slots: Array[InvSlot]
var new_item: InvItem = preload("res://Scenes/inventory/items/wrench.tres")

func insert(item: InvItem):
	var itemslots = slots.filter(func(slot): return slot.item == item)
	if !itemslots.is_empty():
		if item.stackable:
			itemslots[0].amount += 1
		else:
			var emptyslots = slots.filter(func(slot): return slot.item == null)
			if !emptyslots.is_empty():
				emptyslots[0].item = item
				emptyslots[0].amount = 1
	else: 
		var emptyslots = slots.filter(func(slot): return slot.item == null)
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			emptyslots[0].amount = 1
		
	update.emit()
	
func delete(amount: int, texture: Texture2D):
	var itemslots = slots.filter(func(slot): return slot.item && slot.item.texture == texture && slot.amount == amount)
	if !itemslots.is_empty():
		var i = itemslots.size()
		if itemslots[i-1].amount >= 1:
			itemslots[i-1].amount -= 1
func add(texture: Texture2D):
	var itemslots = slots.filter(func(slot): return slot.item && slot.item.texture == texture)
	if !itemslots.is_empty():
		var i = itemslots.size()
		itemslots[i-1].amount += 1
	
