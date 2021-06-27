extends Node


# Mimic external class registing items here
func _ready():
	register(Item.new("Red Berry", 50, "res://assets/Berries Red.png"))
	register(Item.new("Blue Berry", 50, "res://assets/Berries Blue.png"))
	register(Item.new("Luck Spell Book", 1, "res://assets/Books Gold Blue.png"))
	register(Item.new("Curse Spell Book", 1, "res://assets/Books Gold Brown.png"))
	register(Item.new("Stick", -1, "res://assets/Stick Brown A.png"))
	register(Item.new("Knife", -1, "res://assets/Knife Brown Clean.png"))
	register(Item.new("Heal Potion", 8, "res://assets/Potion Red Vial.png"))
	register(Item.new("Mana Potion", 8, "res://assets/Potion Blue Vial.png"))


# Acually DB class start here
var database: Array


func register(item: Item):
	for item2 in database:
		if item == item2:# || item.name == item2.name:
			return
	
	database.append(item)
