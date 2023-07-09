extends Node

@export var level_scenes: Array[PackedScene]
var level_nb: int = 0

func end_game():
	level_nb = 0

func next_level():
	if level_nb == level_scenes.size():
		end_game()
	var level: Level = level_scenes[level_nb].instantiate()
	$World.add_child(level)
	level.level_complete.connect(_on_level_complete)
	level_nb += 1

func _ready():
	next_level()


func _on_level_complete(surviving_zombies):
	for child in $World.get_children():
		child.queue_free()
	next_level()