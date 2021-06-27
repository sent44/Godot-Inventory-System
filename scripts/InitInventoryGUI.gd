extends GridContainer


func _ready():
	for panel in get_children():
		remove_child(panel)
		panel.queue_free()
	for _i in range(Player.inventory.database.size()):
		var panel: Panel = preload("res://prefabs/panel.tscn").instance()
		panel.set_script(preload("res://scripts/SlotPanel.gd"))
		add_child(panel)
