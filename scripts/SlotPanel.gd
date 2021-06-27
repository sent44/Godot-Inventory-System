extends Panel


func _ready():
	# Generate random items just for prototyping
	if get_parent() is GridContainer:
		randomize()
		if randf() < 0.3:
			var item: Item = ItemDB.database[randi() % ItemDB.database.size()]
			if item.size != -1:
				set_slot(Inventory.Slot.new(item, randi() % item.size + 1))
			else:
				set_slot(Inventory.Slot.new(item))
		else:
			set_slot(Inventory.Slot.new(null))
	
	# Start here
	_gui_update()


func _input(event: InputEvent):
	if event is InputEventMouseMotion:
		var position: Vector2 = get_viewport().get_mouse_position()
		if get_global_rect().has_point(position):
			var flat: StyleBoxFlat = StyleBoxFlat.new()
			flat.bg_color = Color(0.4, 0.4, 0.4)
			add_stylebox_override("panel", flat)
		else:
			var flat: StyleBoxFlat = StyleBoxFlat.new()
			flat.bg_color = Color(0.6, 0.6, 0.6)
			add_stylebox_override("panel", flat)
	if event is InputEventKey:
		if event.pressed && event.scancode == KEY_E:
			var position: Vector2 = get_viewport().get_mouse_position()
			if get_global_rect().has_point(position):
				var slot: Inventory.Slot = get_slot()
				slot.count -= 1
				if slot.count <= 0:
					remove_slot()


func _gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		Player.mouse_slot.slot_click(event, self)


func _on_slot_count_change(count: int):
	get_child(1).text = String(count)


func _gui_update():
	var slot: Inventory.Slot = Player.inventory.database[get_index()]
	if !slot.is_empty:
		get_child(0).texture = load(slot.item.texture)
		get_child(1).visible = slot.item.size > 1
		if !slot.is_connected("count_change", self, "_on_slot_count_change"):
			var __ = slot.connect("count_change", self, "_on_slot_count_change")
		_on_slot_count_change(slot.count)
	else:
		get_child(0).texture = null
		get_child(1).visible = false


func get_slot():
	return Player.inventory.database[get_index()]


func set_slot(slot: Inventory.Slot):
	if get_slot() != null:
		if get_slot().is_connected("count_change", self, "_on_slot_count_change"):
			get_slot().disconnect("count_change", self, "_on_slot_count_change")
	Player.inventory.database[get_index()] = slot
	if !slot.is_connected("count_change", self, "_on_slot_count_change"):
		var __ = slot.connect("count_change", self, "_on_slot_count_change")
	_gui_update()


func remove_slot():
	if get_slot().is_connected("count_change", self, "_on_slot_count_change"):
		get_slot().disconnect("count_change", self, "_on_slot_count_change")
	Player.inventory.database[get_index()] = Inventory.Slot.new(null)
	
	_gui_update()
