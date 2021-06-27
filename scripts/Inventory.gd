class_name Inventory extends Object


class Slot extends Object:
	signal count_change
	
	var item: Item
	var count: int setget _set_count
	var is_empty: bool setget , _get_item_empty
	
	func _init(item2: Item, count2: int = -2):
		item = item2
		if item == null:
			count = 0
		elif item.size < 1 || count2 == -2:
			count = 1
		else:
			count = count2
	
	func _set_count(count2: int):
		count = count2
		emit_signal("count_change", count)
	
	func _get_item_empty():
		return item == null


# Inventory slot database
var database: Array

func _init(size: int):
	database.resize(size)
