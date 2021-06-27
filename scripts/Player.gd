extends Node

# Fake player node
var slot_count: int = 66
onready var inventory: Inventory = Inventory.new(slot_count)
var mouse_slot: CanvasLayer
