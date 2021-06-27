class_name Item extends Resource


export var name: String
export var size: int
export var texture: String


func _init(item_name: String, stack_size: int, texture_path: String):
	name = item_name
	size = stack_size
	texture = texture_path
