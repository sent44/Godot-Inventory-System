extends CanvasLayer


onready var mouse: Panel = get_child(0)
onready var slot: Inventory.Slot = Inventory.Slot.new(null)

func _ready():
	Player.mouse_slot = self


func _input(event: InputEvent):
	if event is InputEventMouseMotion:
		mouse.rect_position = event.position - Vector2(5, 5)


func slot_click(event: InputEventMouseButton, object: Panel):
	if event.pressed:
		match event.button_index:
			BUTTON_LEFT:
				if slot.is_empty:
					slot = object.get_slot()
					object.remove_slot()
				else:
					var slot2: Inventory.Slot = object.get_slot()
					if slot2.is_empty:
						object.set_slot(slot)
						slot = Inventory.Slot.new(null)
					elif slot.item == slot2.item:
						var max_count: int = slot.item.size
						if slot2.count == max_count:
							var temp: int = slot.count
							slot.count = slot2.count
							slot2.count = temp
						else:
							var count: int = slot2.count + slot.count
							if count > max_count:
								slot.count = count - max_count
								slot2.count = max_count
							else:
								slot2.count += slot.count
								slot = Inventory.Slot.new(null)
					else:
						object.set_slot(slot)
						slot = slot2
			BUTTON_RIGHT:
				if slot.is_empty:
					var slot2: Inventory.Slot = object.get_slot()
					if !slot2.is_empty:
						if slot2.count == 1:
							slot = slot2
							object.remove_slot()
						else:
							var count: int = int(floor(float(slot2.count) / 2))
							slot = Inventory.Slot.new(slot2.item, count)
							slot2.count -= count
							if slot2.count <= 0:
								object.remove_slot()
		
		_update_gui()


func _update_gui():
	var texture: TextureRect = mouse.get_child(0)
	var label: Label = mouse.get_child(1)
	if !slot.is_empty:
		texture.texture = load(slot.item.texture)
		label.visible = slot.item.size > 1
		label.text = String(slot.count)
	else:
		texture.texture = null
		label.visible = false
